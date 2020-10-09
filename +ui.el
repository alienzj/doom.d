;;; ../projects/doom.d/+ui.el -*- lexical-binding: t; -*-

;; (load-theme 'doom-one-light t)
(load-theme 'doom-one t)

(when (display-graphic-p)
  (setq user-font
        (cond
         ((find-font (font-spec :name  "monospace")) "monospace")
         ((find-font (font-spec :name  "Droid Sans Mono")) "Droid Sans Mono")
         ((find-font (font-spec :name  "Droid Sans Fallback")) "Droid Sans Fallback")))
  (cond (IS-MAC
         (setq doom-font (font-spec :family user-font :size 14)
               doom-big-font (font-spec :family user-font :size 20)
               doom-modeline-height 32))
        (IS-LINUX
         (setq resolution-factor (eval (/ (x-display-pixel-height) 1080.0)))
         (setq doom-font (font-spec :family user-font :size (eval (round (* 12 resolution-factor))))
               doom-big-font (font-spec :family user-font :size (eval (round (* 18 resolution-factor))))
               doom-modeline-height (eval (round (* 12 resolution-factor))))))

  ;; set initl screen size
  (setq initial-frame-alist
        '((width . 110)
          (height . 65))))

(after! doom-modeline
  (setq doom-modeline-buffer-file-name-style 'relative-from-project
        doom-modeline-major-mode-icon t
        ;; My mac vsplit screen won't fit
        doom-modeline-window-width-limit (- fill-column 10)))

(setq +workspaces-on-switch-project-behavior t)

(remove-hook 'doom-init-ui-hook #'blink-cursor-mode)

;; disable line-numbers by default
;; (setq display-line-numbers-type nil)

(defface breakpoint-enabled '((t)) "Breakpoint face.")

;; my custom faces
;; (custom-set-faces!
;;   '(variable-pitch :family nil)
;;   '(font-lock-doc-face :italic t)
;;   '(font-lock-comment-face :italic t)
;;   `(show-paren-match :background ,(doom-lighten (doom-color 'teal) 0.4) :foreground ,(doom-color 'base1))
;;   '(tide-hl-identifier-face :inherit 'lsp-face-highlight-read)
;;   `(breakpoint-enabled :background ,(doom-color 'red) :foreground "white")
;;   `(lsp-ui-peek-highlight :foreground "white")
;;   ;;`(ivy-posframe-border :background ,(doom-color 'blue))
;;   `(magit-diff-file-heading :background ,(doom-lighten (doom-color 'blue) 0.5))
;;   `(magit-diff-file-heading-highlight :background ,(doom-lighten (doom-color 'blue) 0.2))
;;   '(markdown-header-face-1 :inherit 'org-level-1)
;;   '(markdown-header-face-2 :inherit 'org-level-2)
;;   '(markdown-header-face-3 :inherit 'org-level-3)
;;   `(web-mode-jsx-depth-1-face :background ,(doom-lighten (doom-color 'teal) 0.9))
;;   `(web-mode-jsx-depth-2-face :background ,(doom-lighten (doom-color 'teal) 0.8))
;;   `(web-mode-jsx-depth-3-face :background ,(doom-lighten (doom-color 'teal) 0.7))
;;   `(web-mode-jsx-depth-4-face :background ,(doom-lighten (doom-color 'teal) 0.6))
;;   `(web-mode-jsx-depth-5-face :background ,(doom-lighten (doom-color 'teal) 0.5))
;;   `(flyspell-incorrect :underline ,(doom-color 'red))
;;   `(flyspell-duplicate :underline ,(doom-color 'orange))
;;   '(flymake-warning :underline (:style wave :color ,(doom-color 'yellow)))
;;   `(flycheck-warning :underline (:style wave :color ,(doom-color 'yellow)))
;;   `(flycheck-error :underline (:style wave :color ,(doom-color 'red)))
;;   `(flycheck-info :underline (:style wave :color ,(doom-color 'green)))
;;   `(rime-default-face :background ,(doom-lighten (doom-color 'red) 0.85))
;;   `(doom-modeline-debug-visual :background ,(doom-lighten (doom-color 'red) 0.85))
;;   `(ein:cell-input-area :background ,(doom-lighten (doom-color 'red) 0.85))
;;   `(ein:cell-input-prompt :background ,(doom-color 'red) :foreground ,(doom-color 'base0) :bold t))

;; (custom-theme-set-faces! 'doom-city-lights
;;   `(hl-line :background ,(doom-color 'base0))
;;   `(magit-diff-file-heading-highlight :foreground ,(doom-color 'base0))
;;   `(magit-diff-file-heading :foreground ,(doom-color 'base4))
;;   ;; ediff
;;   `(ediff-current-diff-A :foreground ,(doom-color 'red)   :background ,(doom-darken (doom-color 'red) 0.8))
;;   `(ediff-current-diff-B :foreground ,(doom-color 'green) :background ,(doom-darken (doom-color 'green) 0.8))
;;   `(ediff-current-diff-C :foreground ,(doom-color 'blue)  :background ,(doom-darken (doom-color 'blue) 0.8))
;;   `(ediff-current-diff-Ancestor :foreground ,(doom-color 'teal)  :background ,(doom-darken (doom-color 'teal) 0.8))
;;   `(markdown-code-face :background ,(doom-color 'base2)))

(use-package! lsp-ui
  :commands lsp-ui-mode
  :config
  (setq
   lsp-ui-sideline-enable nil
   lsp-ui-sideline-ignore-duplicate t
   lsp-ui-doc-header nil
   lsp-ui-doc-include-signature nil
   lsp-ui-doc-background (doom-color 'base4)
   lsp-ui-doc-border (doom-color 'fg)

   lsp-ui-peek-force-fontify nil
   lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs)))

  (custom-set-faces
   '(ccls-sem-global-variable-face ((t (:underline t :weight extra-bold))))
   '(lsp-face-highlight-read ((t (:background "sea green"))))
   '(lsp-face-highlight-write ((t (:background "brown4"))))
   '(lsp-ui-sideline-current-symbol ((t (:foreground "grey38" :box nil))))
   '(lsp-ui-sideline-symbol ((t (:foreground "grey30" :box nil)))))

  (defhydra hydra/ref (evil-normal-state-map "x")
    "reference"
    ("p" (-let [(i . n) (lsp-ui-find-prev-reference)]
           (if (> n 0) (message "%d/%d" i n))) "prev")
    ("n" (-let [(i . n) (lsp-ui-find-next-reference)]
           (if (> n 0) (message "%d/%d" i n))) "next")
    ("R" (-let [(i . n) (lsp-ui-find-prev-reference '(:role 8))]
           (if (> n 0) (message "read %d/%d" i n))) "prev read" :bind nil)
    ("r" (-let [(i . n) (lsp-ui-find-next-reference '(:role 8))]
           (if (> n 0) (message "read %d/%d" i n))) "next read" :bind nil)
    ("W" (-let [(i . n) (lsp-ui-find-prev-reference '(:role 16))]
           (if (> n 0) (message "write %d/%d" i n))) "prev write" :bind nil)
    ("w" (-let [(i . n) (lsp-ui-find-next-reference '(:role 16))]
           (if (> n 0) (message "write %d/%d" i n))) "next write" :bind nil)
    )
  )

;; for terminal
(unless (display-graphic-p)
  (custom-set-faces!
    `(mode-line :background ,(doom-lighten (doom-color 'blue) 0.8) :foreground ,(doom-color 'fg))
    `(mode-line-inactive :background ,(doom-color 'base1) :foreground ,(doom-color 'fg))
    `(font-lock-comment-face :foreground ,(doom-color 'base6))
    `(font-lock-doc-face :foreground ,(doom-color 'base6))))

;; (when IS-MAC
;;   ;; enable ligatures support
;;   ;; details here: https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
;;   (ignore-errors
;;     (mac-auto-operator-composition-mode)))

(after! ibuffer
  ;; set ibuffer name column width
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 50 50 :left :nil) " "
                (size-h 9 -1 :right) " "
                (mode 16 16 :left :elide) " "
                filename-and-process))))

(add-hook! 'process-menu-mode-hook
  (setq-local tabulated-list-format [("Process" 30 t)
                                     ("PID"      7 t)
                                     ("Status"   7 t)
                                     ("Buffer"  15 t)
                                     ("TTY"     12 t)
                                     ("Command"  0 t)]))

(after! centered-window
  (setq cwm-centered-window-width 160))


;; doom modeline rime segment
(after! (:and doom-modeline rime)
  (set-face-attribute 'rime-indicator-face nil
                      :foreground 'unspecified
                      :inherit 'doom-modeline-buffer-major-mode)
  (set-face-attribute 'rime-indicator-dim-face nil
                      :foreground 'unspecified
                      :inherit 'doom-modeline-buffer-minor-mode)

  (doom-modeline-def-segment input-method
    "Define the current input method properties."
    (propertize (cond (current-input-method
                       (concat (doom-modeline-spc)
                               current-input-method-title
                               (doom-modeline-spc)))
                      ((and (bound-and-true-p evil-local-mode)
                            (bound-and-true-p evil-input-method))
                       (concat
                        (doom-modeline-spc)
                        (nth 3 (assoc default-input-method input-method-alist))
                        (doom-modeline-spc)))
                      (t ""))
                'face (if (doom-modeline--active)
                          (or (get-text-property 0 'face (rime-lighter))
                              'doom-modeline-buffer-major-mode)
                        'mode-line-inactive)
                'help-echo (concat
                            "Current input method: "
                            current-input-method
                            "\n\
mouse-2: Disable input method\n\
mouse-3: Describe current input method")
                'mouse-face 'mode-line-highlight
                'local-map mode-line-input-method-map))
  )

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
;; (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

;; nyancat
;; (setq nyan-wavy-trail t)
;; (setq nyan-animate-nyancat t)
;; (nyan-mode)

;; info-colors
(use-package! info-colors
  :commands (info-colors-fontify-node))
(add-hook 'Info-selection-hook 'info-colors-fontify-node)
(add-hook 'Info-mode-hook #'mixed-pitch-mode)

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
