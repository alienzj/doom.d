;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;; disabled packages
(disable-packages! solaire-mode
                   anaconda-mode
                   company-anaconda
                   lsp-python-ms
                   pyimport)
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
(package! magit-delta :recipe (:host github :repo "dandavison/magit-delta"))
(package! bazel-mode :recipe (:host github :repo "bazelbuild/emacs-bazel-mode"))
(package! import-js)
;; (package! importmagic)
(package! py-isort)
(package! flycheck-mypy)
(package! flycheck-google-cpplint :recipe (:host github :repo "flycheck/flycheck-google-cpplint"))

;; org
(package! org-ref)
(package! org-static-blog)
(package! org-special-block-extras)
(package! ebib)
(package! org-roam-server)
(package! org-alert)
(package! org-ql)
(package! org-super-agenda)
(package! writeroom-mode)

;; text
(package! adoc-mode)
(package! edit-indirect)
(package! youdao-dictionary)
(package! link-hint)
(package! symbol-overlay)

;; ui
(package! rainbow-identifiers)
(package! nyan-mode)
;;(package! darkplus :recipe (:host github :repo "popcorn4dinner/darkplus-emacs" :files ("*")))
;;(package! awesome-tab :recipe (:host github :repo "manateelazycat/awesome-tab" :files ("*")))
(package! info-colors)

;; misc
(package! helm)
(package! dired-narrow)
(package! atomic-chrome)
(package! git-link)
(package! wucuo)
(package! counsel-etags)
(package! imenu-list)
(package! tmux-pane)
(package! lsp-docker)
(package! rime :recipe (:host github :repo "DogLooksGood/emacs-rime" :files ("*.el" "Makefile" "lib.c")))
(package! color-rg :recipe (:host github :repo "manateelazycat/color-rg"))
(package! snails :recipe (:host github :repo "manateelazycat/snails"))
(package! fuz :recipe (:host github :repo "rustify-emacs/fuz.el"))
(package! highlight-indent-guides)

;; doraemon
(package! calibre-mode :recipe (:host github :repo "whacked/calibre-mode" :files ("*")))
(package! ddragon :recipe (:host github :repo "xuchunyang/ddragon.el" :files ("*")))
(package! anki-editor)
(package! esup)
(package! graphviz-dot-mode)
(package! hungry-delete)
(package! systemd)
(package! google-translate)
(package! dad-joke)
(package! kana :recipe (:host github :repo "chenyanming/kana"))
(package! proxy-mode :recipe (:host github :repo "stardiviner/proxy-mode"))
(package! emacs-rainbow-fart :recipe (:host github :repo "stardiviner/emacs-rainbow-fart"))
(package! elgantt :recipe (:host github :repo "legalnonsense/elgantt"))
