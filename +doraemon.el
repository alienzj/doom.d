;;; ../projects/doom.d/+doraemon.el -*- lexical-binding: t; -*-

;; splash
(setq fancy-splash-image (concat zj-project-dir "doom.d/lige.png"))


;; elfeed
(defun bjm/elfeed-show-all ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-all"))

(defun bjm/elfeed-show-daily ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-daily"))

(defun bjm/elfeed-show-emacs ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-emacs"))

(defun bjm/elfeed-show-research ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-research"))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  ;; (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  ;; (elfeed-db-save)
  (quit-window))

(use-package elfeed
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list (concat zj-org-dir "elfeed.org")))
  (setq-default elfeed-search-filter "@10-week-ago")
  :bind (:map elfeed-search-mode-map
         ("A" . bjm/elfeed-show-all)
         ("D" . bjm/elfeed-show-daily)
         ("E" . bjm/elfeed-show-emacs)
         ("R" . bjm/elfeed-show-research)
         ("q" . bjm/elfeed-save-db-and-bury)))


;; tramp
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")
  (appendq! tramp-remote-path
            '("~/.conda/envs/bioenv/bin"
              "~/.cargo/bin"
              "~/.nodejs/bin"
              "~/.go/bin"
              "~/.emacs.d/bin"
              "~/.perl5/bin"
              ))
  (setq tramp-inline-compress-start-size 4096000)
  )
