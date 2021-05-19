;;; private/email/config.el -*- lexical-binding: t; -*-

(after! mu4e
  (require 'org-mu4e)
  (setq
   mu4e-maildir (expand-file-name "~/.local/share/mail/gmail")
   mu4e-attachment-dir "~/.local/share/mail/gmail/mu4e"
   mu4e-get-mail-command "mbsync jpl"
   mu4e-user-mail-address-list '("alienchuj@gmail.com")
   user-mail-address "alienchuj@gmail.com"
   user-full-name "Jie Zhu")
  ())
