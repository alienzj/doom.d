;;; ../projects/doom.d/+doraemon.el -*- lexical-binding: t; -*-

;; splash
(setq fancy-splash-image (concat zj-project-dir "doom.d/lige.png"))


;; elfeed
(setq rmh-elfeed-org-files (list (concat zj-org-dir "elfeed.org")))
(setq-default elfeed-search-filter "@10-week-ago")
(setf url-queue-timeout 120)


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
