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
      bibtex-completion-bibliography '((concat zj-org-dir "references.bib"))
      bibtex-completion-library-path  (concat zj-org-dir "pdf/")
      bibtex-completion-pdf-field "File"
      reftex-default-bibliography bibtex-completion-bibliography
      ;; org-noter-notes-search-path '((concat zj-org-dir "ref/"))
      org-noter-notes-search-path '("~/documents/doraemon/org/ref/")
      org-roam-directory org-directory)

;; ebib
(after! ebib
  ([f5] 'ebib)
  (ebib-bibtex-dialect 'biblatex)
  (ebib-index-window-size 10)
  (ebib-preload-bib-files '((concat zj-org-dir "references.bib")))
  (ebib-file-search-dirs '((concat zj-org-dir "pdf/")))
  (ebib-reading-list-file (concat zj-org-dir "toread_list.org"))
  (ebib-keywords-file (concat zj-org-dir "ebib_keywords.txt"))
  (ebib-keywords-field-keep-sorted t)
  (ebib-keywords-file-save-on-exit 'always)
  (ebib-file-associations '(("pdf")) "using Emacs to open pdf")
  (ebib-use-timestamp t "recording the time that entries are added")
  (ebib-index-columns '(("Entry Key" 20 t)
                        ("Author/Editor" 40 nil)
                        ("Year" 6 t)
                        ("Title" 50 t)))
  (ebib-index-default-sort '("timestamp" . descend)))

;; org-ref
;; (use-package! org-ref
;; (after! org-ref
;; (bibtex-set-dialet 'BibTex)
;;  (org-ref-default-bibliography '("~/documents/doraemon/org/references.bib"))
;;  (org-ref-pdf-directory (concat zj-org-dir "pdf/"))
;;  (org-ref-show-broken-links nil)
;;  (org-ref-default-ref-type "eqref")
;;  (org-ref-default-citation-link "citet"))
;; )
