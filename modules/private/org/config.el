;;; private/org/config.el -*- lexical-binding: t; -*-

;; variables
(setq references_bib (concat zj-org-dir "references.bib"))
(setq references_pdf (concat zj-org-dir "pdf_bib/"))
(setq references_pdf_source (concat zj-org-dir "pdf/"))
(setq references_note (concat zj-org-dir "ref/"))

;; keymap: z-M
(setq org-cycle-hide-block-startup t)

;;; org
(setq org-journal-encrypt-journal t
      org-directory zj-org-dir
      org-agenda-files (list "inbox.org" "agenda.org" "notes.org" "projects.org")
      org-ellipsis " ▼ "
      org-babel-python-command "python3"
      org-bullets-bullet-list '("#")
      org-download-screenshot-method "flameshot gui --raw > %s"
      org-download-image-dir (concat zj-org-dir "resource/images/"))

;; ref
;; https://github.com/rougier/emacs-gtd
;;
;; Capture
(setq org-capture-templates
      `(("i" "Inbox" entry  (file "inbox.org")
         ,(concat "* TODO %?\n"
                  "/Entered on/ %U"))
        ("m" "Meeting" entry  (file+headline "agenda.org" "Future")
         ,(concat "* %? :meeting:\n"
                  "<%<%Y-%m-%d %a %H:00>>"))
        ("n" "Note" entry  (file "notes.org")
         ,(concat "* Note (%a)\n"
                  "/Entered on/ %U\n" "\n" "%?"))
        ("@" "Inbox [mu4e]" entry (file "inbox.org")
         ,(concat "* TODO Reply to \"%a\" %?\n"
                  "/Entered on/ %U"))))

(defun org-capture-inbox ()
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "i"))

(defun org-capture-mail ()
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "@"))

;; Use full window for org-capture
(add-hook 'org-capture-mode-hook 'delete-other-windows)

;; Key bindings
(define-key global-map            (kbd "C-c a") 'org-agenda)
(define-key global-map            (kbd "C-c c") 'org-capture)
(define-key global-map            (kbd "C-c i") 'org-capture-inbox)

;; Only if you use mu4e
;(require 'mu4e)
;(define-key mu4e-headers-mode-map (kbd "C-c i") 'org-capture-mail)
;(define-key mu4e-view-mode-map    (kbd "C-c i") 'org-capture-mail)
;; Refile
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-targets
      '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")))

;; TODO
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

;; Agenda
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks\n")))
          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-format-date "")
                   (org-deadline-warning-days 7)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header "\nDeadlines")))
          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "\nInbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")))))))

;; Save the corresponding buffers
(defun gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda ()
                         (when (member (buffer-file-name) org-agenda-files)
                           t)))
  (message "Saving org-agenda-files buffers... done"))

;; Add it after refile
(advice-add 'org-refile :after
            (lambda (&rest _)
              (gtd-save-org-buffers)))

(setq org-agenda-hide-tags-regexp ".")

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        ;; (todo   . " %i %-12:c")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))

(setq org-log-done 'time)
;; pdf
;;(require 'eaf-org)
;;(defun eaf-org-open-file (file &optional link)
;;  (eaf-open file))
;; (add-to-list 'org-file-apps '("\\.pdf\\'" . eaf-org-open-file))

;; (use-package! org-pdftools
;;   :after pdf-tools
;;   :config
;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00169.html
;;   ;; Before adding, remove it (to avoid clogging)
;;   (delete '("\\.pdf\\'" . default) org-file-apps)
;;   ;; https://lists.gnu.org/archive/html/emacs-orgmode/2016-11/msg00176.html
;;   (add-to-list 'org-file-apps
;;                '("\\.pdf\\'" . (lambda (file link)
;;                                  (org-pdftools-open link)
;;                                  ;; (eaf-org-open-file link)
;;                                  ))))

;; org-ref
;; https://github.com/jkitchin/org-ref/blob/master/org-ref.org
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
   ;; org-ref-default-bibliography (list references_bib)
   bibtex-completion-bibliography (list references_bib)
   ;; org-ref-pdf-directory references_pdf
   bibtex-completion-library-path references_pdf
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
  )


;; org-noter
(setq org-noter-notes-search-path (list references_note))


;; org-media-note
(require 'org-attach)
(use-package! org-media-note
  :init (setq org-media-note-use-org-ref t)
  :hook (org-mode . org-media-note-mode)
  :bind (("s-v" . org-media-note-hydra/body))
  :config
  (setq org-media-note-screenshot-image-dir (concat zj-org-dir "resource/images/"))
  (setq org-media-note-use-refcite-first t))


;; plantuml
(setq plantuml-jar-path  "/usr/share/java/plantuml/plantuml.jar"
      org-plantuml-jar-path plantuml-jar-path)


;; org-roam
(use-package! org-roam
  :config
  ;; (setq org-roam-directory (concat zj-org-dir "roam"))
  (setq
   ;; org-roam-directory (concat zj-org-dir "note/")
   org-roam-directory zj-org-dir
   org-roam-db-location (concat zj-org-dir ".org-roam.db")
   )
  )

;(setq org-roam-capture-templates
;      '(
;        ("d" "default" plain (function org-roam-capture--get-point)
;         "%?"
;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;         :head "#+title: ${title}\n#+roam_alias:\n\n")
;        ("g" "group")
;        ("ga" "Group A" plain (function org-roam-capture--get-point)
;         "%?"
;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;         :head "#+title: ${title}\n#+roam_alias:\n\n")
;        ("gb" "Group B" plain (function org-roam-capture--get-point)
;         "%?"
;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;         :head "#+title: ${title}\n#+roam_alias:\n\n")))

;(add-to-list 'org-roam-capture-templates
;             '("t" "Term" plain (function org-roam-capture--get-point)
;               "- 领域: %^{术语所属领域}\n- 释义:"
;               :file-name "%<%Y%m%d%H%M%S>-${slug}"
;               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
;               :unnarrowed t
;               ))

;(add-to-list 'org-roam-capture-templates
;             '("p" "Paper Note" plain (function org-roam-capture--get-point)
;               "* 相关工作\n\n%?\n* 观点\n\n* 模型和方法\n\n* 实验\n\n* 结论\n"
;               :file-name "%<%Y%m%d%H%M%S>-${slug}"
;               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
;               :unnarrowed t
;               ))

;(setq org-roam-capture-immediate-template
;      '("d" "default" plain (function org-roam-capture--get-point)
;        "%?"
;        :file-name "%<%Y%m%d%H%M%S>-${slug}"
;        :head "#+title: ${title}\n"
;        :unnarrowed t))


;; 实现网页内容摘录
;; (setq org-roam-capture-ref-templates
;;       '(("r" "ref" plain (function org-roam-capture--get-point)
;;          ""
;;          :file-name "${slug}"
;;          :head "#+title: ${title}\n#+roam_key: ${ref}\n"
;;          :unnarrowed t)))

;(add-to-list 'org-roam-capture-ref-templates
;             '("a" "Annotation" plain (function org-roam-capture--get-point)
;               "%U ${body}\n"
;               :file-name "${slug}"
;               :head "#+title: ${title}\n#+roam_key: ${ref}\n#+roam_alias:\n"
;               :immediate-finish t
;               :unnarrowed t))
;; javascript:location.href = 'org-protocol://roam-ref?template=r&ref=' + encodeURIComponent(location.href) + '&title=' + encodeURIComponent(document.title)
;; javascript:location.href = 'org-protocol://roam-ref?template=a&ref=' + encodeURIComponent(location.href) + '&title='+encodeURIComponent(document.title) + '&body='+encodeURIComponent(function(){var html = "";var sel = window.getSelection();if (sel.rangeCount) {var container = document.createElement("div");for (var i = 0, len = sel.rangeCount; i < len; ++i) {container.appendChild(sel.getRangeAt(i).cloneContents());}html = container.innerHTML;}var dataDom = document.createElement('div');dataDom.innerHTML = html;['p', 'h1', 'h2', 'h3', 'h4'].forEach(function(tag, idx){dataDom.querySelectorAll(tag).forEach(function(item, index) {var content = item.innerHTML.trim();if (content.length > 0) {item.innerHTML = content + '&#13;&#10;';}});});return dataDom.innerText.trim();}())

;; org-roam-server
                                        ;(use-package! org-roam-server
                                        ;  ;; :after (ogr-roam server)
                                        ;  :config
                                        ;  (setq org-roam-server-host "127.0.0.1"
                                        ;        org-roam-server-port 8078
                                        ;        org-roam-server-authenticate nil
                                        ;        org-roam-server-export-inline-images t
                                        ;        org-roam-server-serve-files nil
                                        ;        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
                                        ;        org-roam-server-network-poll t
                                        ;        org-roam-server-network-arrows nil
                                        ;        org-roam-server-network-label-truncate t
                                        ;        org-roam-server-network-label-truncate-length 60
                                        ;        org-roam-server-network-label-wrap-length 20)
                                        ;
                                        ;  (defun org-roam-server-open ()
                                        ;    "Ensure the server is active, then open the roam graph."
                                        ;    (interactive)
                                        ;    (smartparens-global-mode -1)
                                        ;    (org-roam-server-mode 1)
                                        ;    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))
                                        ;    (smartparens-global-mode 1)
                                        ;    )
                                        ;  (org-roam-server-mode 1)
                                        ;  )

;; automatically enable server-mode
                                        ;(after! org-roam
                                        ;  (smartparens-global-mode -1)
                                        ;  (org-roam-server-mode)
                                        ;  (smartparens-global-mode 1))

;; org-roam-bibtex
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode))

(use-package! ox-gfm
  :after org)

(use-package! org-pandoc-import
  :after org
  )


;; ivy
(setq ivy-read-action-function #'ivy-hydra-read-action)
(setq ivy-sort-max-size 50000)


;; org-chef
(use-package! org-chef
  :commands (org-chef-insert-recipe org-chef-get-recipe-from-url))


(sp-local-pair
 '(org-mode)
 "<<" ">>"
 :actions '(insert))

(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(after! org-agenda
  (org-super-agenda-mode))

;; (setq org-agenda-skip-scheduled-if-done t
;;       org-agenda-skip-deadline-if-done t
;;       org-agenda-include-deadlines t
;;       org-agenda-block-separator nil
;;       org-agenda-tags-column 100 ;; from testing this seems to be a good value
;;       org-agenda-compact-blocks t)

;; (setq org-agenda-custom-commands
;;       '(("o" "Overview"
;;          ((agenda "" ((org-agenda-span 'day)
;;                       (org-super-agenda-groups
;;                        '((:name "Today"
;;                           :time-grid t
;;                           :date today
;;                           :todo "TODAY"
;;                           :scheduled today
;;                           :order 1)))))
;;           (alltodo "" ((org-agenda-overriding-header "")
;;                        (org-super-agenda-groups
;;                         '((:name "Next to do"
;;                            :todo "NEXT"
;;                            :order 1)
;;                           (:name "Important"
;;                            :tag "Important"
;;                            :priority "A"
;;                            :order 6)
;;                           (:name "Due Today"
;;                            :deadline today
;;                            :order 2)
;;                           (:name "Due Soon"
;;                            :deadline future
;;                            :order 8)
;;                           (:name "Overdue"
;;                            :deadline past
;;                            :face error
;;                            :order 7)
;;                           (:name "Assignments"
;;                            :tag "Assignment"
;;                            :order 10)
;;                           (:name "Issues"
;;                            :tag "Issue"
;;                            :order 12)
;;                           (:name "Emacs"
;;                            :tag "Emacs"
;;                            :order 13)
;;                           (:name "Projects"
;;                            :tag "Project"
;;                            :order 14)
;;                           (:name "Research"
;;                            :tag "Research"
;;                            :order 15)
;;                           (:name "To read"
;;                            :tag "Read"
;;                            :order 30)
;;                           (:name "Waiting"
;;                            :todo "WAITING"
;;                            :order 20)
;;                           (:name "University"
;;                            :tag "uni"
;;                            :order 32)
;;                           (:name "Trivial"
;;                            :priority<= "E"
;;                            :tag ("Trivial" "Unimportant")
;;                            :todo ("SOMEDAY" )
;;                            :order 90)
;;                           (:discard (:tag ("Chore" "Routine" "Daily")))))))))))

;; org to jupyter notebook
(require 'ox-ipynb)


;; orgcss
;; https://github.com/gongzhitaao/orgcss
;; (setq org-html-htmlize-output-type 'inline-css)
;; (setq org-html-htmlize-output-type nil)
                                        ;(setq org-html-htmlize-output-type 'css)


;; notebook-mode
;; https://github.com/rougier/notebook-mode/blob/master/notebook.org
;;(use-package! notebook-mode
;;  :after org)
(setq notebook-mode t)

(setq flycheck-disabled-checkers '(proselint))
