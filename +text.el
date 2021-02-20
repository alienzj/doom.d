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
(setq references_pdf (concat zj-org-dir "pdf/"))
(setq references_note (concat zj-org-dir "ref/"))

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
(use-package! ebib
  :config
  (setq ebib-file-search-dirs references_pdf)
  (setq ebib-notes-directory references_note)
  (setq ebib-preload-bib-files (list references_bib)))

;; org-media-note
;; https://github.com/yuchen-lea/org-media-note/blob/master/README_CN.org
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
