;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; user information
(setq user-full-name user-login-name
      user-mail-address "alienchuj@gmail.com"
      epa-file-encrypt-to user-mail-address
      zj-home (concat "/home/" user-login-name "/")
      zj-project-dir (concat zj-home "projects/")
      zj-document-dir (concat zj-home "documents/")
      zj-doraemon-dir (concat zj-document-dir "doraemon/")
      zj-org-dir (concat zj-doraemon-dir "org/")
      zj-blog-dir (concat zj-org-dir "blog/alienzj.github.io/"))

(load! "+dayfun")
(load! "+ui")
(load! "+org")
(load! "+blog")
(load! "+code")

;; better defaults
(setq tab-width 4
      undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      inhibit-compacting-font-caches t)

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
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*"))

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
