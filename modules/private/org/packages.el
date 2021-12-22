;; -*- no-byte-compile: t; -*-
;;; private/org/packages.el

(package! org-ref)
(package! org-static-blog)
(package! citeproc-org)

;(package! org-roam-server)
(package! org-roam-bibtex)
;; (package! company-org-roam)

(package! gscholar-bibtex)
(package! mpv)
(package! org-media-note :recipe (:host github :repo "yuchen-lea/org-media-note"))
(package! zotxt)
(package! org-super-agenda)
(package! doct :recipe (:host github :repo "progfolio/doct"))
(package! org-fragtog)
(package! org-appear)
(package! org-pretty-tags)
(package! ox-gfm)
(package! org-graph-view :recipe (:host github :repo "alphapapa/org-graph-view"))
(package! org-chef)
(package! org-pandoc-import :recipe
  (:host github :repo "tecosaur/org-pandoc-import" :files ("*.el" "filters" "preprocessors")))
(package! ox-ipynb :recipe
  (:host github :repo "jkitchin/ox-ipynb" :files ("*")))
(package! notebook-mode :recipe
  (:host github :repo "rougier/notebook-mode" :files ("*")))
