;;; ../projects/doom.d/+doraemon.el -*- lexical-binding: t; -*-

;; input method
(setq pyim-default-scheme 'rime)

;; google-translate
(use-package google-translate
  :defer t
  :config
  (global-set-key "\C-ct" 'google-translate-at-point))

;; dad-joke
(use-package dad-joke
  :defer t
  :config (defun dad-joke() (interactive) (insert (dad-joke-get))))

(setq fancy-splash-image (concat zj-project-dir "doom.d/lige.png"))

;; elfeed
(setq rmh-elfeed-org-files (list (concat zj-org-dir "elfeed.org")))
(setq-default elfeed-search-filter "@10-week-ago")
(setf url-queue-timeout 120)

;; ddragon
(setq ddragon-dir (concat zj-document-dir "database/lol"))

;; anki-editor
(setq anki-editor-create-decks t)

;; tramp
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (setq doom-projectile-fd-binary (executable-find "fd"))
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")
  (add-to-list 'tramp-remote-path "~/.emacs.d/bin")
  (add-to-list 'tramp-remote-path "~/.perl5/bin")
  (add-to-list 'tramp-remote-path "~/.go/bin")
  (add-to-list 'tramp-remote-path "~/.nodejs/bin")
  (add-to-list 'tramp-remote-path "~/.cargo/bin")
  (add-to-list 'tramp-remote-path "~/.conda/envs/bioenv/bin")
  (setq tramp-inline-compress-start-size 4096000)
  )

;; calibre-mode
;;(def-package! calibre-mode
;;  :config
;;  (setq sql-sqlite-program "/usr/bin/sqlite3"
;;        calibre-root-dir (expand-file-name (concat zj-home "documents/doraemon/books/calibre"))
;;        calibre-db (concat calibre-root-dir "/metadata.db")))

;; debug
;;(setq debug-on-error t)

;; set proxy
(setenv "ALL_PROXY" "socks5h://127.0.0.1:9909")
