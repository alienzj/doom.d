;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el


(package! snakemake-mode)

(package! pkgbuild-mode)

(package! wdl-mode)

(package! polymode)
(package! poly-markdown)
(package! poly-R)
(package! poly-wdl)
(package! ess-view)

(package! ddragon :recipe (:host github :repo "xuchunyang/ddragon.el" :files ("*")))

(package! anki-editor)

;;(package! darkplus :recipe (:host github :repo "popcorn4dinner/darkplus-emacs" :files ("*")))

;;(package! awesome-tab :recipe (:host github :repo "manateelazycat/awesome-tab" :files ("*")))

(package! tldr)
(package! esup)
(package! calibre-mode :recipe (:host github :repo "whacked/calibre-mode" :files ("*")))
(package! rainbow-identifiers)
(package! nyan-mode)

;;(package! darkplus :recipe (:host github :repo "popcorn4dinner/darkplus-emacs" :files ("*")))
;;(package! awesome-tab :recipe (:host github :repo "manateelazycat/awesome-tab" :files ("*")))

(package! graphviz-dot-mode)
(package! hungry-delete)

(package! atomic-chrome)

(package! mermaid-mode :recipe (:host github :repo "abrochard/mermaid-mode" :files("*")))

(package! ob-mermaid :recipe (:host github :repo "arnm/ob-mermaid" :files("*")))

(package! interleave :recipe (:host github :repo "rudolfochrist/interleave" :files("*")))

;; Air Quality Index(AQI)
;;(package! aqi :recipe (:host github :repo "zzkt/aqi" :files("*")))

;; BNF Mode for GNU Emacs
(package! bnf-mode)

;;(package! lsp-treemacs)

(package! magit-delta :recipe (:host github :repo "dandavison/magit-delta"))

(package! info-colors)

(package! org-ref)
(package! org-brain)
(package! org-pdftools :recipe (:host github :repo "fuxialexander/org-pdftools" :files("*")))
(package! org-super-agenda)
(package! doct :recipe (:host github :repo "progfolio/doct"))
(package! org-pretty-table-mode :recipe (:host github :repo "Fuco1/org-pretty-table"))
(package! org-fragtog)
(package! org-pretty-tags)

;;(package! org-gfm)
(package! org-graph-view :recipe (:host github :repo "alphapapa/org-graph-view"))
(package! org-chef)
;;(package! org-plot)

(package! org-roam-server)

(package! systemd)
