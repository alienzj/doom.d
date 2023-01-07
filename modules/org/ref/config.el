;;; org/ref/config.el -*- lexical-binding: t; -*-

;; org-citar
(setq org-cite-csl-styles-dir (concat jack-document-dir "zotero/styles"))

(setq! bibtex-completion-bibliography '(references_bib))
(setq! citar-bibliography '(references_bib))

(setq! bibtex-completion-library-path '(references_pdf references_pdf_source)
       bibtex-completion-notes-path references_note)

(setq! citar-library-paths '(references_pdf references_pdf_source)
       citar-notes-paths '(references_note))
