;;; private/jupyter/config.el -*- lexical-binding: t; -*-

;; emacs-jupyter
(setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                     (:session . "py")))

;; add <p for python expansion
;; ;(add-to-list 'org-structure-template-alist
                                        ;'("p" "#+begin_src jupyter-python :session /jpy:127.0.0.1:8888\n#+end_src"
                                        ; "<src lang=\"python\">\n?\n</src>"))

;; add <r for R expansion
                                        ;(add-to-list 'org-structure-template-alist
                                        ;'("p" "#+begin_src r :results output org drawer\n?\n#+end_src"
                                        ;"<src lang=\"r\">\n?\n</src>"))


(defun insert_jupyter_header ()
  (interactive)
  (insert "#+begin_src jupyter-python :session /jpy:127.0.0.1:8888\n\n#+end_src"))

(global-set-key (kbd "C-c v") 'insert_jupyter_header)


(after! org
       (define-key org-mode-map "\C-cs"
         (lambda()(interactive)(insert "#+BEGIN_SRC R\n#+END_SRC")))
       )
