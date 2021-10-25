;;; private/jupyter/config.el -*- lexical-binding: t; -*-

;; emacs-jupyter
(setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                     (:session . "py")))


(global-set-key (kbd "C-c v")
"#+BEGIN_SRC jupyter-python :session /jpy:127.0.0.1:8888

#+END_SRC")
