;; -*- no-byte-compile: t; -*-
;;; private/eaf/packages.el

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
