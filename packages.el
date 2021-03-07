;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;; disabled packages
;; (disable-packages! anaconda-mode
;;                    lsp-python-ms)
;;
;; eaf
(package! eaf
  :recipe (:host github
           :repo "manateelazycat/emacs-application-framework"
           :files ("*")
           :build (:not compile)))
(package! ctable)
(package! epc)

;; snails
(package! fuz)
(package! snails :recipe (:host github :repo "manateelazycat/snails" :build (:not compile)))

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
;; (package! ebib)
(package! citeproc-org)
(package! org-roam-server)

;; https://github.com/org-roam/org-roam-bibtex#doom-emacs
(package! org-roam-bibtex :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(unpin! org-roam company-org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)

;; elfeed
(package! elfeed-dashboard)

;; ui
(package! rainbow-identifiers)
(package! nyan-mode)
(package! good-scroll)
(package! pretty-hydra)
;; (unpin! treemacs)

;; doraemon
(package! gscholar-bibtex
  :recipe (:host github :repo "cute-jumper/gscholar-bibtex" :files ("*.el")))

;; note
(package! mpv)
(package! org-media-note :recipe (:host github :repo "yuchen-lea/org-media-note"))

;; zotero
(package! zotxt)
