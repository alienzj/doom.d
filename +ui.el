;;; ../projects/doom.d/+ui.el -*- lexical-binding: t; -*-

;; doom-theme
(setq doom-theme 'doom-one)
(setq user-font
      (cond
       ((find-font (font-spec :name  "monospace")) "monospace")
       ((find-font (font-spec :name  "Droid Sans Mono")) "Droid Sans Mono")
       ((find-font (font-spec :name  "Droid Sans Fallback")) "Droid Sans Fallback")))
(setq doom-font (font-spec :family user-font :size 23)
      doom-big-font (font-spec :family user-font :size 23)
      doom-modeline-height 10)


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

(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-saturation 72  ;80 ;125
      rainbow-identifiers-cie-l*a*b*-lightness 72   ;45 ;100
      ;; override theme faces
      rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
                                              font-lock-keyword-face
                                              font-lock-function-name-face
                                              font-lock-variable-name-face))
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)


;; nyancat
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)


;; centaur-tabs
(use-package centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 30
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
  ;; (setq centaur-tabs-gray-out-icons 'buffer)
  ;; (centaur-tabs-enable-buffer-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
  ;; projectile integration
  (centaur-tabs-group-by-projectile-project)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (setq centaur-tabs-cycle-scope 'tabs)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  ("C-c t s" . centaur-tabs-counsel-switch-group)
  ("C-c t p" . centaur-tabs-group-by-projectile-project)
  ("C-c t g" . centaur-tabs-group-buffer-groups)
  ;;  (:map evil-normal-state-map
  ;;    ("g t" . centaur-tabs-forward)
  ;;    ("g T" . centaur-tabs-backward))
  )
