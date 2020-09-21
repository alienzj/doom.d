;;; ../projects/doom.d/+org.el -*- lexical-binding: t; -*-

;; org, org-noter, bibtex
(after! org
  (add-to-list 'org-modules 'org-habit t))

(setq org-journal-encrypt-journal t
      org-directory zj-org-dir
      org-download-screenshot-method "flameshot gui --raw > %s"
      org-download-image-dir (concat zj-org-dir "images/")
      bibtex-completion-bibliography '((concat zj-org-dir "references.bib"))
      bibtex-completion-library-path  (concat zj-org-dir "pdf/")
      bibtex-completion-pdf-field "File"
      reftex-default-bibliography bibtex-completion-bibliography
      org-noter-notes-search-path '((concat zj-org-dir "ref/"))
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
(after! org-ref
  (bibtex-dialet 'BibTex)
  (org-ref-default-bibliography '("~/documents/doraemon/org/references.bib"))
  (org-ref-pdf-directory (concat zj-org-dir "pdf/"))
  (org-ref-show-broken-links nil)
  (org-ref-default-ref-type "eqref")
  (org-ref-default-citation-link "citet"))

;; org-super-agenda
(let ((org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"  ; Optionally specify section name
          :time-grid t  ; Items that appear on the time grid
          :todo "TODAY")  ; Items that have this TODO keyword
         (:name "Important"
          ;; Single arguments given alone
          :tag "bills"
          :priority "A")
         ;; Set order of multiple groups at once
         (:order-multi (2 (:name "Shopping in town"
                           ;; Boolean AND group matches items that match all subgroups
                           :and (:tag "shopping" :tag "@town"))
                          (:name "Food-related"
                           ;; Multiple args given in list with implicit OR
                           :tag ("food" "dinner"))
                          (:name "Personal"
                           :habit t
                           :tag "personal")
                          ;;(:name "Space-related (non-moon-or-planet-related)"
                          ;; Regexps match case-insensitively on the entire entry
                          ;;       :and (:regexp ("space" "NASA")
                          ;; Boolean NOT also has implicit OR between selectors
                          ;;             :not (:regexp "moon" :tag "planet")))
                          ))
         ;; Groups supply their own section names when none are given
         (:todo "WAITING" :order 8)  ; Set order of this section
         (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
          ;; Show this group at the end of the agenda (since it has the
          ;; highest number). If you specified this group last, items
          ;; with these todo keywords that e.g. have priority A would be
          ;; displayed in that group instead, because items are grouped
          ;; out in the order the groups are listed.
          :order 9)
         (:priority<= "B"
          ;; Show this section after "Today" and "Important", because
          ;; their order is unspecified, defaulting to 0. Sections
          ;; are displayed lowest-number-first.
          :order 1)
         ;; After the last group, the agenda will display items that didn't
         ;; match any of these groups, with the default order position of 99
         )))
  (org-agenda nil "a"))

;; org-alert
(setq alert-default-style 'libnotify)
