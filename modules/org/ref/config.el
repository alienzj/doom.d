;;; org/ref/config.el -*- lexical-binding: t; -*-

;; org-citar
(setq org-cite-csl-styles-dir (concat zj-document-dir "zotero/styles"))

(setq! bibtex-completion-bibliography '(references_bib))
(setq! citar-bibliography '(references_bib))

(setq! bibtex-completion-library-path '(references_pdf references_pdf_source)
       bibtex-completion-notes-path references_note)

(setq! citar-library-paths '(references_pdf references_pdf_source)
       citar-notes-paths '(references_note))


;; org-roam
(use-package! org-roam
  :config
  (setq
   org-roam-directory (concat jack-org-dir "note/")
   org-roam-directory jack-org-dir
   org-roam-db-location (concat jack-org-dir ".org-roam.db")
   )
  )
