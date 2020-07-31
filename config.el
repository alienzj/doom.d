;;; .doom.d/config.el -*- lexical-binding: t; -*-


;; user information
(setq user-full-name "alienzj"
      user-mail-address "alienchuj@gmail.com"
      epa-file-encrypt-to user-mail-address)


;; better defaults
(setq-default
 delete-by-moving-to-trash t
 tab-width 4
 uniquify-buffer-name-style 'forward
 window-combination-resize t
 x-stretch-cursor t
 history-length 1000
 prescient-history-length 1000)


(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      inhibit-compacting-font-caches t
      ;;truncate-streing-ellipsis "..."
      )


;; time-mode
(display-time-mode t)


;; evil
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-split)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)
(map! :map evil-window-map
      "SPC" #'rotate-layout)


;; enable auto-completion
(after! company
  (setq
   ;; IMO, modern editors have trained a bad habit into us all: a burning
   ;; need for completion all the time -- as we type, as we breathe, as we
   ;; pray to the ancient ones -- but how often do you *really* need that
   ;; information? I say rarely. So opt for manual completion:
   ;;company-idle-delay nil
   company-idle-delay 0.2
   company-minimum-prefix-length 3
   company-show-numbers t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))

(set-company-backend! '(text-mode
                        markdown-mode
                        gfm-mode)
  '(:seperate company-ispell
    company-files
    company-yasnippet))

(set-company-backend!
  'ess-r-mode
  '(company-R-args company-R-objects company-dabbrev-code :separate))


;; scratch-lisp
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)


;; doom ui
(setq doom-font (font-spec :family "monospace" :size 23) ;;:weight 'semi-light)
      ;;doom-variable-pitch-font (font-spec :family "sans" :size 23)
      ;;doom-unicode-font (font-spec :family "sans")
      ;;doom-big-font (font-spec :family "sans" :size 28)

      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-themes-treemacs-theme "doom-colors"

      ;;doom-theme 'doom-dracula
      ;;doom-theme 'doom-solarized-dark
      ;;doom-theme 'doom-molokai)
      ;;all-the-icons-scale-factor 1.0
      )

(doom-themes-treemacs-config)
(doom-themes-org-config)

;;(custom-theme-set-faces! 'doom-dracula
;;  `(markdown-code-face :background ,(doom-darken 'bg 0.075))
;;  `(font-lock-variable-name-face :foreground ,(doom-lighten 'magenta 0.6)))

(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")


;; mode line
(setq
 ;;doom-modeline-height 4
 ;;doom-modeline-bar-width 2
 doom-modeline-icon t)

;; don't compact font caches during GC
(setq inhibit-compacting-font-caches t)

;;(setq doom-modeline-height 1)
;;(set-face-attribute 'mode-line nil :family "Noto Sans" :height 100)
;;(set-face-attribute 'mode-line-inactive nil :family "Noto Sans" :height 100)

;;(defun my-doom-modeline--font-height ()
;;  "Calculate the actual char height of the mode-line."
;;  (+ (frame-char-height) 3))
;;(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)


;; lsp ui
(setq lsp-ui-sideline-enable nil
      lsp-enable-symbol-highlighting nil)


;; markdown
(use-package! atomic-chrome
  :after-call focus-out-hook
  :config
  (setq atomic-chrome-default-major-mode 'markdown-mode
        atomic-chrome-buffer-open-style 'frame)
  (atomic-chrome-start-server))


;; prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))


;; keybinds
(map! :n [tab] (cmds! (and (featurep! :editor fold)
                           (save-excursion (end-of-line) (invisible-p (point))))
                      #'+fold/toggle
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item)
      :v [tab] (cmds! (and (bound-and-true-p yas-minor-mode)
                           (or (eq evil-visual-selection 'line)
                               (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                      #'yas-insert-snippet
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item)

      :leader
      "h L" #'global-keycast-mode
      "f t" #'find-in-dotfiles
      "f T" #'browse-dotfiles)


;; ivy
(after! ivy
  ;; I prefer search matching to be ordered; it's more precise
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus)))


;; I don't need the menu. I know all the shortcuts.
;;(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)


;; switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)


;; silence all that useless output
(setq direnv-always-show-summary nil)


;;; :ui doom-dashboard
(setq fancy-splash-image "~/projects/doom.d/splash.png")



;;(add-hook 'completion-list-mode-hook #'hide-mode-line-mode)
;;(add-hook 'neotree-mode-hook #'hide-mode-line-mode)


;;(defun remove-fringes ()
;;  (set-window-fringes nil 0 0)
;;  (set-window-margins nil 0 0))


;; treemacs
;;(after! treemacs
;;  (add-hook 'treemacs-select-hook #'remove-fringes))


;; magit
(after! magit
  (magit-delta-mode +1)
  (setq magit-repository-directories '(("~/projects" .2))
        magit-save-repository-buffers nil
        magit-inhibit-save-previous-winconf t))


;;(after! magit
;;  (add-hook 'magit-post-display-buffer-hook #'remove-fringes t)
;;  (add-hook! magit-popup-mode-hook #'remove-fringes))


;; org, org-ref, org-noter, bibtex
(after! org
  (add-to-list 'org-modules 'org-habit t))

(setq org-journal-encrypt-journal t
      org-journal-file-format "%Y%m%d.org"
      org-ellipsis " ▼ "
      org-superstar-headline-bullets-list '("#")
      org-directory "~/documents/doraemon/org/"
      org-download-image-dir "~/documents/doraemon/org/images"

      bibtex-completion-bibliography '("~/documents/doraemon/org/reference/references.bib")
      bibtex-completion-library-path "~/documents/doraemon/org/reference/pdf"
      bibtex-completion-pdf-field "File"
      bibtex-completion-notes-path "~/documents/doraemon/org/note/references.org"

      reftex-default-bibliography '("~/documents/doraemon/org/reference/references.bib")

      org-noter-default-notes-file-names '("references.org")
      org-noter-notes-search-path '("~/documents/doraemon/org/note")
      org-noter-separate-notes-from-heading t

      org-roam-directory "~/documents/doraemon/org/note/")


;; open pdf with system pdf viewer
(setq bibtex-completion-pdf-open-function
      (lambda (fqpath)
        (start-process "open" "*open" "open" fqpath)))


;; ebib
;; https://emacs-china.org/t/emacs/12580/6
(use-package ebib
  :general
  ([f5] 'ebib)
  :custom
  (ebib-bibtex-dialect 'biblatex)
  (ebib-index-window-size 10)
  (ebib-preload-bib-files '("~/documents/doraemon/org/reference/references.bib"))
  (ebib-notes-use-single-file "~/documents/doraemon/org/note/references.org")
  (ebib-file-search-dirs '("~/documents/doraemon/org/reference/pdf/"))
  (ebib-reading-list-file "~/documents/doraemon/org/note/toread_list.org")
  (ebib-keywords-file "~/documents/doraemon/org/reference/ebib_keywords.txt")
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
(use-package org-ref
  ;;:general
  ;;(z-spc-leader-def "r" 'org-ref-hydra/body)
  ;;:pretty-hydra
  ;;((:color red :quit-key "q")
  ;; ("Insert"
  ;;  (("i" org-ref-helm-insert-cite-link "citation key")
  ;;   ("r" org-ref-helm-insert-ref-link "ref link")
  ;;   ("l" org-ref-helm-insert-label-link "label link"))
  ;;  "Browse"
  ;;  (("b" helm-bibtex "bibtex")
  ;;   ("s" crossref-lookup "lookup"))
  ;;  "Add"
  ;;  (("a" crossref-add-bibtex-entry "new entry")
  ;;   ("d" doi-add-bibtex-entry "doi"))))
  :custom
  (bibtex-dialect 'biblatex)
  (org-ref-bibliography-notes "~/documents/doraemon/org/note/references.org")
  (org-ref-default-bibliography '("~/documents/doraemon/org/reference/references.bib"))
  (org-ref-pdf-directory "~/documents/doraemon/org/reference/pdf/")
  (org-ref-show-broken-links nil)
  (org-ref-default-ref-type "eqref")
  (org-ref-default-citation-link "citet")
  :config
  (require 'org-ref-citeproc)
  (defun org-ref-grep-pdf (&optional _candidate)
    "Search pdf files of marked CANDIDATEs."
    (interactive)
    (let ((keys (helm-marked-candidates))
          (get-pdf-function org-ref-get-pdf-filename-function))
      (helm-do-pdfgrep-1
       (-remove (lambda (pdf)
                  (string= pdf ""))
                (mapcar (lambda (key)
                          (funcall get-pdf-function key))
                        keys)))))
  (helm-add-action-to-source "Grep PDF" 'org-ref-grep-pdf helm-source-bibtex 1)

  (setq helm-bibtex-map
        (let ((map (make-sparse-keymap)))
          (set-keymap-parent map helm-map)
          (define-key map (kbd "C-s") (lambda () (interactive)
                                        (helm-run-after-exit 'org-ref-grep-pdf)))
          map))
  (push `(keymap . ,helm-bibtex-map) helm-source-bibtex))


;; org-roam
(use-package org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8078
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-label-truncate t
        org-roam-server-label-truncate-length 60
        org-roam-server-label-wrap-length 20)
  (defun org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (org-roam-server-mode 1)
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))))


;; deft
(setq deft-extensions '("txt" "tex" "org")
      deft-directory "~/documents/doraemon/org"
      deft-recursive t)


;; elfeed
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))


;; lookup
;;(setq +lookup-open-url-fn #'eww)


;; ddragon
(setq ddragon-dir "~/documents/database/lol")


;; vscode
(defun xah-open-in-vscode ()
  "Open current file or dir in vscode. Version 2019-11-04"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name) default-directory )))
    (cond
     ((string-equal system-type "darwin")
      (shell-command (format "open -a Visual\\ Studio\\ Code.app \"%s\"" $path)))
     ((string-equal system-type "windows-nt")
      (shell-command (format "Code \"%s\"" $path)))
     ((string-equal system-type "gnu/linux")
      (shell-command (format "code \"%s\"" $path))))))


;; anki-editor
(setq anki-editor-create-decks t)


;; conda
;;(require 'conda)
;;(setq conda-anaconda-home "~/.conda/envs/bioenv")
;;(conda-env-initialize-interactive-shells)
;;(conda-env-initialize-eshell)
;;(conda-env-autoactivate-mode t)


;; tramp
;;(setq tramp-default-method "ssh")
;;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*"))


;; rust
(setq rustic-lsp-server 'rust-analyzer)


;; calibre-mode
;;(def-package! calibre-mode
;;  :config
;;  (setq sql-sqlite-program "/usr/bin/sqlite3"
;;        calibre-root-dir (expand-file-name "~/documents/doraemon/books/calibre")
;;        calibre-db (concat calibre-root-dir "/metadata.db")))


;; debug
;;(setq debug-on-error t)


;; rainbow color
(defun colorit ()
  (interactive)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode))

;;(add-hook 'rustic-mode-hook #'colorit t)
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-saturation 72  ;80 ;125
      rainbow-identifiers-cie-l*a*b*-lightness 72   ;45 ;100
      ;; override theme faces
      rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
                                              font-lock-keyword-face
                                              font-lock-function-name-face
                                              font-lock-variable-name-face))


;; nyan
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)


;; pomodoro
(defun ding-ding-ding ()
  "Ding whatever the settings are."
  (interactive)
  (require 'cl-macs)
  (let ((ring-bell-function nil)
        (visible-bell nil))
    (loop repeat 100 do (ding) (other-frame 0) (sit-for 1))))

(defun zj-pomodoro ()
  "Ding after a pomodoro time"
  (interactive)
  (run-at-time "25 min" nil 'ding-ding-ding))


;; firefox
(defun save-firefox-session ()
  "Reads firefox current session and coverts it to org-mode chunk."
  (interactive)
  (save-excursion
    (let* ((path "~/.mozilla/firefox/6eb49djq.default-release/sessionstore-backups/recovery.jsonlz4")
           (cmd (concat "lz4jsoncat " path " | grep -oP '\"(http:.+?)\"|\"(https:.+?)\"' | sed 's/\"//g' | sort | uniq "))
           (ret (shell-command-to-string cmd)))
      (insert
       (concat
        "* "
        (format-time-string "[%Y-%m-%d %H:%M:%S]")
        "\n"
        (mapconcat 'identity
                   (cl-reduce (lambda (lst x)
                                (if (and x (not (string= "" x)))
                                    (cons (concat "  - " x) lst)
                                  lst))
                              (split-string ret "\n")
                              :initial-value (list))
                   "\n"))))))

(defun restore-firefox-session ()
  "Restore session, by openning each link in list with (browse-url).
Make sure to put cursor on date heading that contains list of urls."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (looking-at "^\\*")
      (forward-line 1)
      (while (looking-at "^[ ]+-[ ]+\\(http.?+\\)$")
        (let* ((ln (thing-at-point 'line t))
               (ln (replace-regexp-in-string "^[ ]+-[ ]+" "" ln))
               (ln (replace-regexp-in-string "\n" "" ln)))
          (browse-url ln))
        (forward-line 1)))))


;; centaur-tabs
(use-package centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        centaur-tabs-set-close-button nil
        x-underline-at-descent-line t)
  (centaur-tabs-enable-buffer-reordering)
  ;;(centaur-tabs-change-fonts "arial" 23)
  (setq centaur-tabs-adjust-buffer-order t
        centaur-tabs-adjust-buffer-order 'right)
  (centaur-tabs-headline-match)
  ;; (setq centaur-tabs-gray-out-icons 'buffer)
  ;; (centaur-tabs-enable-buffer-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  ;; projectile integration
  (centaur-tabs-group-by-projectile-project)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (setq centaur-tabs-cycle-scope 'tabs)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups)
  ;;  (:map evil-normal-state-map
  ;;    ("g t" . centaur-tabs-forward)
  ;;    ("g T" . centaur-tabs-backward))
  )


;; aqi, air quality
;;(use-package! aqi
;;  :config (setq aqi-api-key ""
;;                aqi-use-cache t
;;                aqi-report "Shenzhen"
;;                aqi-city-aqi "Shenzhen"))

;;https://github.com/lassik/emacs-format-all-the-code/issues/76
;; ESS, R
(setenv "R_HOME" nil)


;; ccls
;;(use-package ccls)
;;(setq ccls-executable "/usr/bin/ccls")


;; lsp-treemacs
;;(lsp-treemacs-sync-mode 1)


;; info-colors
(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(add-hook 'Info-mode-hook #'mixed-pitch-mode)


;; text-mode
(after! text-mode
  (add-hook! 'text-mode-hook
             ;; Apply ANSI color codes
             (with-silent-modifications
               (ansi-color-apply-on-region (point-min) (point-max)))))


;; format-all
;; clang-format
(after! format
  (set-formatter! 'clang-format
    '("clang-format"
      "-style={BasedOnStyle: LLVM, IndentWidth: 4, BreakBeforeBraces: Allman, SortIncludes: true}"
      ("-assume-filename=%S" (or buffer-file-name mode-result "")))
    ))

;; org-static-blog
(define-key global-map "\C-cb" 'zj/publish-to-blog)

(cl-defun zj/publish-to-blog (&optional (draft nil) (local nil))
  (load-file "blog.el")
  (preview-article :draft draft)
  (unless draft (publish))
  (let ((server (if local "http://localhost:4000/" "https://alienzj.github.io/")))
    (async-shell-command (concat "open " server NAME "/") "*blog-post-in-browser*"))
  )
