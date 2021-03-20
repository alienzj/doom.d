;;; private/org/config.el -*- lexical-binding: t; -*-

;;; org
(setq org-journal-encrypt-journal t
      org-directory zj-org-dir
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-babel-python-command "python3"
      org-bullets-bullet-list '("#")
      org-download-screenshot-method "flameshot gui --raw > %s"
      org-download-image-dir (concat zj-org-dir "images/")
      org-roam-directory org-directory)

;; hide PROPERTIES
;; https://emacs-china.org/t/emacs-org-mode-drawer-help-wanted/15207/20
;; (defun org-hide-properties ()
;;   "Hide org headline's properties using overlay."
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while (re-search-forward
;;             "^ *:PROPERTIES:\n\\( *:.+?:.*\n\\)+ *:END:\n" nil t)
;;       (overlay-put (make-overlay
;;                     (match-beginning 0) (match-end 0))
;;                    'display ""))))
;; (add-hook 'org-mode-hook #'org-hide-properties)

;; org-pdftools
;; PDF links for org-mode
;; https://github.com/manateelazycat/emacs-application-framework/wiki/Org
(require 'eaf-org)
(defun eaf-org-open-file (file &optional link)
  "An wrapper function on `eaf-open'."
  (eaf-open file))

;; use `emacs-application-framework' to open PDF file: link
;; (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file))

(use-package! org-pdftools
  :after pdf-tools
  :config
  ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00169.html
  ;; Before adding, remove it (to avoid clogging)
  (delete '("\\.pdf\\'" . default) org-file-apps)
  ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00176.html
  (add-to-list 'org-file-apps
               '("\\.pdf\\'" . (lambda (file link)
                                 ;; (org-pdftools-open link)
                                 (eaf-org-open-file link)
                                 ))))

;; org-ref
;; https://github.com/jkitchin/org-ref/blob/master/org-ref.org
(setq references_bib (concat zj-org-dir "references.bib"))
(setq references_pdf (concat zj-org-dir "pdf_bib/"))
(setq references_pdf_source (concat zj-org-dir "pdf/"))
(setq references_note (concat zj-org-dir "ref/"))

(require 'org-ref)
(require 'org-ref-wos)
(require 'org-ref-scopus)
(require 'org-ref-pubmed)
(require 'org-ref-arxiv)
(require 'org-ref-sci-id)

;; https://github.com/jkitchin/org-ref/issues/656
(defun my/org-ref-move-buffer-file (oldname newname)
  "moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (progn
    (copy-file oldname newname 1)
    (set-visited-file-name newname)
    (set-buffer-modified-p nil)
    t))

;; https://github.com/jkitchin/org-ref/pull/763
(defun orcb-add-file-field ()
  "Add a file field pointing to the PDF for this entry."
  (bibtex-beginning-of-entry)
  (let* ((entry (bibtex-parse-entry))
         (key (cdr (assoc "=key=" entry)))
         (pdf (org-ref-get-pdf-filename key)))
    ;; (doi-utils-get-bibtex-entry-pdf)
    (interactive (format "orcb-add-file-field: key is %s" key))
    (message (format "orcb-add-file-field: key is %s" key))
    (interctive (format "orcb-add-file-field: pdf is %s" pdf))
    (message (format "orcb-add-file-field: pdf is %s" pdf))
    (bibtex-set-field "file" pdf)))
;; (add-hook 'org-ref-clean-bibtex-entry-hook 'orcb-add-file-field t)

(defun my/link-pdf-file (oldname newname)
  (interactive (format "link pdf %s to %s" oldname newname))
  (message (format "link pdf %s to %s" oldname newname))
  (make-symbolic-link oldname newname))

(defun my/org-ref-open-pdf-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (car (bibtex-completion-find-pdf key))))
    (if (file-exists-p pdf-file)
        (org-open-file pdf-file)
      (message "No PDF found for %s" key))))

;; https://github.com/jkitchin/org-ref/issues/731
(require 'bibtex)
(bibtex-set-dialect 'BibTeX)

(use-package! org-ref
  :after org-roam
  ;; :hook (org-ref-clean-bibtex-entry . orcb-add-file-field)
  ;; (add-hook 'org-ref-clean-bibtex-entry-hook 'orcb-add-file-field)
  :bind (("s-c" . 'org-ref-cite-hydra/body))
  :init
  (setq
   ;; org-ref-pdf-to-bibtex-function 'rename-file
   ;; org-ref-pdf-to-bibtex-function 'copy-file
   org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point
   org-ref-pdf-to-bibtex-function 'my/link-pdf-file)
  :config
  (setq
   org-ref-completion-library 'org-ref-ivy-cite
   reftex-default-bibliography (list references_bib)
   org-ref-default-bibliography (list references_bib)
   org-ref-pdf-directory references_pdf
   ;; org-ref-show-broken-links nil
   ;; org-ref-default-ref-type "eqref"
   ;; org-ref-default-citation-link "citet"
   )
  ;; since we use ivy-bibtex
  (setq bibtex-completion-bibliography (list references_bib)
        bibtex-completion-library-path (list references_pdf references_pdf_source)
        bibtex-completion-find-additional-pdfs t
        bibtex-completion-pdf-field "File")
  ;; format how we generate keys
  (setq bibtex-autokey-year-length 4
        bibtex-autokey-name-year-separator "-"
        bibtex-autokey-year-title-separator "-"
        bibtex-autokey-titleword-separator "-"
        bibtex-autokey-titlewords 2
        bibtex-autokey-titlewords-stretch 1
        bibtex-autokey-titleword-length 5)
  ;; (setq bibtex-completion-pdf-open-function
  ;;       (lambda (fpath)
  ;;         (start-process "okular" nil 0 nil fpath)))
  )

(require 'helm-bibtex)
(require 'ivy-bibtex)
(defun bibtex-completion-open-pdf-external (keys &optional fallback-action)
  (let ((bibtex-completion-pdf-open-function
         (lambda (fpath) (start-process "okular" "*helm-bibtex-okular*" "/usr/bin/okular" fpath))))
    (bibtex-completion-open-pdf keys fallback-action)))

(ivy-bibtex-ivify-action bibtex-completion-open-pdf-external ivy-bibtex-open-pdf-external)

(ivy-add-actions
 'ivy-bibtex
 '(("P" ivy-bibtex-open-pdf-external "Open PDF file in external viewer (if present)")))

;; (let ((org-export-with-broken-links t)
;;       (org-latex-pdf-process
;;        '("pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;          "bibtex %b"
;;          "makeindex %b"
;;          "pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f"
;;          "pdflatex -interaction nonstopmode -shell-escape -output-directory %o %f")))
;;   (org-open-file (org-latex-export-to-pdf)))

;; (let ((org-export-with-broken-links t))
;;   (browse-url (org-html-export-to-html)))

;; org-noter
(setq org-noter-notes-search-path (list references_note))

;; ebib
;; (use-package! ebib
;;   :config
;;   (setq ebib-file-search-dirs references_pdf)
;;   (setq ebib-notes-directory references_note)
;;   (setq ebib-preload-bib-files (list references_bib)))

;; org-media-note
;; https://github.com/yuchen-lea/org-media-note/blob/master/README_CN.org
(require 'org-attach)
(use-package! org-media-note
  :hook (org-mode . org-media-note-setup-org-ref)
  :bind (("s-v" . org-media-note-hydra/body))
  :config
  (setq org-media-note-screenshot-image-dir (concat zj-org-dir "images/"))
  (setq org-media-note-use-refcite-first t))

;; plantuml
(setq plantuml-jar-path  "/usr/share/java/plantuml/plantuml.jar"
      org-plantuml-jar-path plantuml-jar-path)

;; org-roam
;; org-roam-server
(use-package! org-roam-server
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

;; org-roam-bibtex
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode))


;; refnoter
;; call ivy-bibtex, select paper, read and note
(defun =refnoter ()
  "Activate (or switch to) `ivy-bibtex' in its workspace."
  (interactive)
  (if (featurep! :ui workspaces)
      (progn
        (+workspace-switch "refnoter" t)
        (doom/switch-to-scratch-buffer)
        (ivy-bibtex)
        (+workspace/display))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (ivy-bibtex)))
