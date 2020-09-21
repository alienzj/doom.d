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

(load! "+os")
(load! "+misc")
(load! "+ui")
(load! "+text")
(load! "+prog")
(load! "+blog")
(load! "+doraemon")

;; better defaults
(setq doom-scratch-buffer-major-mode 'emacs-lisp-mode)

(setq-default
 tab-width 4
 undo-limit 80000000
 evil-want-fine-undo t
 auto-save-default t
 inhibit-compacting-font-caches t
 fill-column 120
 delete-trailing-lines t)

(delete-selection-mode 1)
