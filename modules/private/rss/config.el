;;; private/rss/config.el -*- lexical-binding: t; -*-

;; elfeed
(use-package! elfeed
  :config
  (setq
   rmh-elfeed-org-files (list (concat zj-org-dir "elfeed.org"))
   elfeed-search-filter "@10-week-ago")

  (map! (:when (featurep! :app rss)
       :map elfeed-search-mode-map
       :n "RET" #'eaf-elfeed-open-url)))
