;; -*- no-byte-compile: t; -*-
;;; private/org/packages.el

(package! org-ref)
(package! org-static-blog)
(package! citeproc-org)
(package! org-roam-server)
(package! org-roam-bibtex :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(unpin! org-roam company-org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
(unpin! treemacs)
(package! gscholar-bibtex :recipe (:host github :repo "cute-jumper/gscholar-bibtex" :files ("*.el")))
(package! mpv)
(package! org-media-note :recipe (:host github :repo "yuchen-lea/org-media-note"))
(package! zotxt)
