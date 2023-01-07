;;; config.el --- Description -*- lexical-binding: t; -*-

;; org-roam
(use-package! org-roam
  :config
  (setq
   ;;org-roam-directory (concat jack-org-dir "note/")
   org-roam-directory jack-org-dir
   org-roam-db-location (concat jack-org-dir ".org-roam.db")

   ;;org-roam-node-display-template
   ;;(concat "${title:*} "
   ;;        (propertize "${tags:10}" 'face 'org-tag))

   ;;* Foo
   ;;  :PROPERTIES:
   ;;  :ID:       foo
   ;;  :ROAM_EXCLUDE: t
   ;;  :END:
   org-roam-db-node-include-function
   (lambda ()
     (not (member "ATTACH" (org-get-tags))))
   )
  )

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
