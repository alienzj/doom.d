;;; private/python/config.el -*- lexical-binding: t; -*-
;;;
;; python
(after! python
  (setq python-indent-offset 4
        python-shell-interpreter "python3"
        pippel-python-command "python3"
        conda-env-home-directory (concat zj-home ".conda/envs/bioenv")
        importmagic-python-interpreter "python3"
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8"))

