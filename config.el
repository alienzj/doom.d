;;; config.el -*- lexical-binding: t; -*-

;; user information
(setq user-full-name user-login-name
      user-mail-address "alienchuj@gmail.com"
      epa-file-encrypt-to user-mail-address)


;; org
(setq
;;;org-journal-encrypt-journal t
 org-directory jack-org-dir
 org-agenda-files (list "agenda.org" "projects.org" "inbox.org" "agenda.org" "notes.org")
 org-download-screenshot-method "flameshot gui --raw > %s"
 org-download-image-dir (concat jack-org-dir "resource/images/"))


;; rss
(after! elfeed
  (setq rmh-elfeed-org-files (list (concat jack-org-dir "elfeed.org"))
        elfeed-search-filter "@1-month-ago +unread"))


;;projectile
(use-package! projectile
  :ensure t
  :init
  (require 'tramp)
  (projectile-mode +1))


;; better defaults
(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)


;; default
(setq-default
 tab-width 4
 undo-limit 80000000
 evil-want-fine-undo t
 auto-save-default t
 inhibit-compacting-font-caches t
 fill-column 120
 ;; delete-trailing-lines t
 )


;; Delete the selection when pasting
(delete-selection-mode 1)


;; popup rules
(set-popup-rules! '(("^\\*helpful" :size 0.35)
                    ("^\\*Ibuffer\\*$" :size 0.35)
                    ("^\\*info.*" :size 80 :side right)
                    ("^\\*Man.*" :size 80 :side right)
                    ("^\\*Customize" :actions display-buffer)
                    ("^\\*edit-indirect" :size 0.6)
                    ("^\\*YASnippet Tables\\*$" :size 0.35)
                    ("^\\*grep\\*$" :size 0.35)
                    ("^\\*color-rg\\*$" :size 0.35)
                    ("^\\*pytest\\*" :size 0.35)
                    ("^\\*Anaconda\\*$" :size 0.35)
                    ("^\\*helm kill ring\\*$" :size 0.35)
                    ("\\*.*server log\\*$" :side top :size 0.20 :select nil)
                    ((lambda (buf _) (with-current-buffer buf (eq major-mode 'forge-topic-mode))) :size 0.35)
                    ))


;; proxy
;;;(setenv "ALL_PROXY" "socks5h://127.0.0.1:9909")


;; profile
(let ((profile "~/.config/doom/profile.el"))
  (when (file-exists-p profile)
    (load-file profile)))
