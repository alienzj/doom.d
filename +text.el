;;; ../projects/doom.d/+text.el -*- lexical-binding: t; -*-

;; org
(setq org-journal-encrypt-journal t
      org-directory zj-org-dir
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ "
      org-babel-python-command "python3"
      org-bullets-bullet-list '("#")
      org-download-screenshot-method "flameshot gui --raw > %s"
      org-download-image-dir (concat zj-org-dir "images/")
      org-roam-directory org-directory)

;; org-ref
(setq references_bib (concat zj-org-dir "references.bib"))
(setq references_pdf (concat zj-org-dir "pdf_bib/"))
(setq references_note (concat zj-org-dir "ref/"))

(setq org-ref-pdf-to-bibtex-function 'rename-file)

;; https://github.com/jkitchin/org-ref/issues/731
;; (bibtex-set-dialect 'BibTex)
(setq bibtex-dialect 'Bibtex)

(setq reftex-default-bibliography (list references_bib))

(setq org-ref-default-bibliography (list references_bib)
      org-ref-pdf-directory references_pdf
      org-ref-show-broken-links nil
      org-ref-default-ref-type "eqref"
      org-ref-default-citation-link "citet")

;; helm-bibtex
(setq bibtex-completion-bibliography references_bib
      bibtex-completion-library-path references_pdf
      bibtex-completion-pdf-field "File")
;; (setq bibtex-completion-pdf-open-function
;;       (lambda (fpath)
;;         (start-process "open" "*open*" "open" fpath)))

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
  :bind (
         ("H-v" . org-media-note-hydra/body))
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
