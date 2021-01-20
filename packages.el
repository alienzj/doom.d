;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;; disabled packages
(disable-packages! anaconda-mode
                   lsp-python-ms)

;; prog
(package! pkgbuild-mode)
(package! snakemake-mode)
(package! wdl-mode)
(package! polymode)
(package! poly-markdown)
(package! poly-R)
(package! poly-wdl)
(package! ess-view)
(package! bnf-mode)
(package! tablegen-mode :ignore t)

;; org
(package! org-ref)
(package! org-static-blog)
(package! ebib)
(package! org-roam-server)

;; ui
(package! rainbow-identifiers)
(package! nyan-mode)

;; doraemon
(package! gscholar-bibtex
  :recipe (:host github :repo "cute-jumper/gscholar-bibtex" :files ("*.el")))
