;;; private/conda/config.el -*- lexical-binding: t; -*-

;; conda
(require 'conda)
(setq conda-anaconda-home (concat jack-home ".conda/envs/bioenv"))
(setq conda-env-home-directory (concat jack-home ".conda/envs/bioenv"))
(setq conda-env-subdirectory "../")
