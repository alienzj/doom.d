;;; private/tex/config.el -*- lexical-binding: t; -*-
;; tex
(after! tex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
  (setq TeX-command-default "XeLaTeX"
        TeX-save-query nil
        TeX-show-compilation t)
  )
