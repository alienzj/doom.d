;;; remote/tramp/config.el -*- lexical-binding: t; -*-


(after! tramp
  (setenv "SHELL" "/usr/bin/zsh")
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
