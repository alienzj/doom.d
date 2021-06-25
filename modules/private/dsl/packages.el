;; -*- no-byte-compile: t; -*-
;;; private/dsl/packages.el

(package! snakemake-mode)
(package! wdl-mode)
(package! nextflow-mode :recipe (:host github :repo "emiller88/nextflow-mode"))

(package! systemd)
(package! bnf-mode)

(package! stan-mode)
(package! company-stan)

(package! eldoc-stan)
(package! flycheck-stan)
(package! stan-snippets)
