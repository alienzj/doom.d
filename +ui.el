;;; ../projects/doom.d/+ui.el -*- lexical-binding: t; -*-

;; doom ui
(setq doom-font (font-spec :family "monospace" :size 23)
      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-themes-treemacs-theme "doom-colors")

;; pixel scroll
(pixel-scroll-mode)
(when (display-graphic-p)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
        mouse-wheel-progressive-speed nil))
(setq scroll-step 1
      scroll-margin 0
      scroll-conservatively 100000)
(setq scroll-step 1
      scroll-margin 0
      scroll-conservatively 100000)


;; https://emacs-china.org/t/topic/2405/20
;; @purcell
(defun sanityinc/adjust-opacity (frame incr)
  "Adjust the background opacity of FRAME by increment INCR."
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))

(global-set-key [f8] (lambda () (interactive) (sanityinc/adjust-opacity nil -2)))
(global-set-key [f9] (lambda () (interactive) (sanityinc/adjust-opacity nil 2)))
(global-set-key [f7] (lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))

;; rainbow color
(defun colorit ()
  (interactive)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode))

;;(add-hook 'rustic-mode-hook #'colorit t)
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-saturation 72  ;80 ;125
      rainbow-identifiers-cie-l*a*b*-lightness 72   ;45 ;100
      ;; override theme faces
      rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
                                              font-lock-keyword-face
                                              font-lock-function-name-face
                                              font-lock-variable-name-face))

;; nyancat
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)

;; info-colors
(use-package! info-colors
  :commands (info-colors-fontify-node))
(add-hook 'Info-selection-hook 'info-colors-fontify-node)
(add-hook 'Info-mode-hook #'mixed-pitch-mode)

;; centaur-tabs
(after! centaur-tabs
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        centaur-tabs-set-close-button nil
        x-underline-at-descent-line t)
  (centaur-tabs-enable-buffer-reordering)
  ;;(centaur-tabs-change-fonts "arial" 23)
  (setq centaur-tabs-adjust-buffer-order t
        centaur-tabs-adjust-buffer-order 'right)
  (centaur-tabs-headline-match)
  (centaur-tabs-group-by-projectile-project))
