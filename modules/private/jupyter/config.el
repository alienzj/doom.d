;;; private/jupyter/config.el -*- lexical-binding: t; -*-

;; emacs-jupyter
(setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                     (:session . "py")))
