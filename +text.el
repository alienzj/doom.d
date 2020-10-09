;;; ../projects/doom.d/+text.el -*- lexical-binding: t; -*-

(add-hook! 'text-mode-hook (setq-local truncate-lines nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! org
  (add-to-list 'org-modules 'org-habit t)
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %?\n%i" :prepend t :kill-buffer t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i" :prepend t :kill-buffer t)

          ;; Will use {project-root}/{todo,notes,changelog}.org, unless a
          ;; {todo,notes,changelog}.org file is found in a parent directory.
          ("p" "Templates for projects")
          ("pt" "Project todo" entry    ; {project-root}/todo.org
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i" :prepend t :kill-buffer t)
          ("pn" "Project notes" entry   ; {project-root}/notes.org
           (file+headline +org-capture-project-notes-file "Inbox")
           "* TODO %?\n%i" :prepend t :kill-buffer t)
          ("pc" "Project changelog" entry ; {project-root}/changelog.org
           (file+headline +org-capture-project-notes-file "Unreleased")
           "* TODO %?\n%i" :prepend t :kill-buffer t)))

  (setq org-log-into-drawer "LOGBOOK")

  ;; Schedule/deadline popup with default time
  (defvar org-default-time "10:30"
    "The default time for deadlines.")

  (defun advise-org-default-time (func arg &optional time)
    (let ((old-time (symbol-function #'org-read-date)))
      (cl-letf (((symbol-function #'org-read-date)
                 #'(lambda (&optional a b c d default-time f g)
                     (let ((default-time (or default-time
                                             org-default-time)))
                       (apply old-time a b c d f default-time g)
                       ))))
        (apply func arg time))))

  (advice-add #'org-deadline :around #'advise-org-default-time)
  (advice-add #'org-schedule :around #'advise-org-default-time))

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

;; (use-package! org-wild-notifier
;;   :defer t
;;   :init
;;   (add-hook 'doom-after-init-modules-hook #'org-wild-notifier-mode t)
;;   :config
;;   (setq org-wild-notifier-alert-time 5
;;         alert-default-style (if IS-MAC 'osx-notifier 'libnotify)))


(after! ox-pandoc
  (setq org-pandoc-options-for-revealjs '((variable . "highlight-theme=github")
                                          (variable . "theme=white"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MARKDOWN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(remove-hook 'text-mode-hook #'auto-fill-mode)


(use-package! edit-indirect :defer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OTHERS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! youdao-dictionary
  :defer t
  :config
  ;; Enable Cache
  (setq url-automatic-caching t
        ;; Set file path for saving search history
        youdao-dictionary-search-history-file
        (concat doom-cache-dir ".youdao")
        ;; Enable Chinese word segmentation support
        youdao-dictionary-use-chinese-word-segmentation t))

(use-package! tldr
  :defer t
  :config
  (setq tldr-directory-path (concat doom-etc-dir "tldr/"))
  (set-popup-rule! "^\\*tldr\\*" :side 'right :select t :quit t)
  )

(use-package! link-hint :defer t)

(use-package! symbol-overlay :defer t)

(after! so-long
  (setq so-long-target-modes (delete 'text-mode so-long-target-modes)))


(use-package! adoc-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist (cons "\\.adoc\\'" 'adoc-mode)))
