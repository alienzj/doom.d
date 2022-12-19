;;; org/noter/config.el -*- lexical-binding: t; -*-

;; org-noter
(setq org-noter-notes-search-path (list references_note))

;; org-media-note
(require 'org-attach)
(use-package! org-media-note
  ;:init (setq org-media-note-use-org-ref t)
  :hook (org-mode . org-media-note-mode)
  :bind (("s-v" . org-media-note-hydra/body))
  :config
  (setq org-media-note-screenshot-image-dir (concat jack-org-dir "resource/images/"))
  (setq org-media-note-use-refcite-first t))