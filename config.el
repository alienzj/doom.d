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
(load! "+ui")
(load! "+text")
(load! "+misc")
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

;; Delete the selection when pasting
(delete-selection-mode 1)

;; disable risky local variables warning
(advice-add 'risky-local-variable-p :override #'ignore)

;; check minified-file
(add-to-list 'magic-mode-alist (cons #'+my/check-minified-file 'fundamental-mode))

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
