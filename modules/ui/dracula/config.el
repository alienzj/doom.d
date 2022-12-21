;;; ui/dracula/config.el -*- lexical-binding: t; -*-


;; doom-theme
;;(setq doom-theme 'doom-one-light)
(setq doom-theme 'doom-one)

(if (display-graphic-p)
    (progn
      (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
      (setq doom-themes-treemacs-theme "Default")
      (doom-themes-treemacs-config)
      ))
(doom-themes-org-config)


;; font
(setq user-font
      (cond
       ((find-font (font-spec :name  "monospace")) "monospace")
       ((find-font (font-spec :name  "Droid Sans Mono")) "Droid Sans Mono")
       ((find-font (font-spec :name  "Droid Sans Fallback")) "Droid Sans Fallback")))

(cond
 ((string= user-login-name "alienzj")
  (setq doom-font (font-spec :family user-font :size 20)
        doom-big-font (font-spec :family user-font :size 20)
        doom-modeline-height 15)
  )

 ((string= user-login-name "zhujie")
  (setq doom-font (font-spec :family user-font :size 20)
        doom-big-font (font-spec :family user-font :size 20)
        doom-modeline-height 20)
  )
 )


;; rainbow
(defun colorit ()
  (interactive)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode))


(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-saturation 72  ;80 ;125
      rainbow-identifiers-cie-l*a*b*-lightness 72   ;45 ;100
      ;; override theme faces
      rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
                                              font-lock-keyword-face
                                              font-lock-function-name-face
                                              font-lock-variable-name-face))
                                        ;(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)


;; nyancat
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)


;; treemacs
(use-package! treemacs
  :config
  (treemacs-define-custom-image-icon "~/.config/doom/images/logo-snake-22.png" "smk" "snakefiles")
  )


;; pixel scroll
;; (pixel-scroll-mode)
;; (when (display-graphic-p)
;;   (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
;;         mouse-wheel-progressive-speed nil))
;; (setq scroll-step 1
;;       scroll-margin 0
;;       scroll-conservatively 100000)
;; (setq scroll-step 1
;;       scroll-margin 0
;;       scroll-conservatively 100000)
;;
;; The built-in pixel-scroll does implement pixel line scrolling,
;; but, unlike good-scroll, does not support dynamic scrolling velocity.
(good-scroll-mode 1)
