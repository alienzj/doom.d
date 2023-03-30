;;; org/noter/config.el -*- lexical-binding: t; -*-

;; pdf-tools
;(use-package! pdf-tools
;  :init
;  (pdf-tools-install)
;)

;; org-media-note
(require 'org-attach)
(use-package! org-media-note
  ;:init (setq org-media-note-use-org-ref t)
  :hook (org-mode . org-media-note-mode)
  :bind (("s-v" . org-media-note-hydra/body))
  :config
  ;(setq org-noter-notes-search-path (list org-directory references_note))
  ;(setq org-noter-notes-search-path (list references_note))
  (setq org-media-note-screenshot-image-dir (concat jack-org-dir "static/images/"))
  (setq org-media-note-use-refcite-first t))

(setq org-noter-notes-search-path (list references_note))
