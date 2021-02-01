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
(setq org-ref-default-bibliography '((concat zj-org-dir "references.bib"))
      org-ref-pdf-directory (concat zj-org-dir "pdf/")
      org-ref-show-broken-links nil
      org-ref-default-ref-type "eqref"
      org-ref-default-citation-link "citet")

;; helm-bibtex
(setq bibtex-completion-bibliography '((concat zj-org-dir "references.bib"))
      bibtex-completion-library-path  (concat zj-org-dir "pdf/")
      bibtex-completion-pdf-field "File")

(setq reftex-default-bibliography bibtex-completion-bibliography)

(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (start-process "open" "*open*" "open" fpath)))

;; org-noter
(setq org-noter-notes-search-path '("~/documents/doraemon/org/ref/"))

;; ebib
(use-package ebib
  :ensure t
  :init
  :config
  (setq ebib-file-search-dirs '((concat zj-org-dir "pdf/")))
  (setq ebib-notes-directory '((concat zj-org-dir "ref/")))
  (setq ebib-preload-bib-files '((concat zj-org-dir "references.bib"))))
