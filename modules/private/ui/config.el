;;; private/ui/config.el -*- lexical-binding: t; -*-
;; splash
;;(setq fancy-splash-image (concat zj-project-dir "doom.d/lige.png"))

;; doom-theme
(setq doom-theme 'doom-one-light)
;;(setq doom-theme 'doom-one)

(if (display-graphic-p)
    (progn
      (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
      (setq doom-themes-treemacs-theme "Default")
      (doom-themes-treemacs-config)
      ))
(doom-themes-org-config)

(setq user-font
      (cond
       ((find-font (font-spec :name  "monospace")) "monospace")
       ((find-font (font-spec :name  "Droid Sans Mono")) "Droid Sans Mono")
       ((find-font (font-spec :name  "Droid Sans Fallback")) "Droid Sans Fallback")))


(cond
 ((string= user-login-name "alienzj")
  (setq doom-font (font-spec :family user-font :size 27)
        doom-big-font (font-spec :family user-font :size 27)
        doom-modeline-height 10)
  )

 ((string= user-login-name "zhujie")
  (setq doom-font (font-spec :family user-font :size 15)
        doom-big-font (font-spec :family user-font :size 15)
        doom-modeline-height 10)
  )
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
;; (use-package! rainbow-mode
;;   :config
;;   (progn
;;     (defun @-enable-rainbow ()
;;       (rainbow-mode t))
;;     (add-hook 'prog-mode-hook '@-enable-rainbow)
;; ))
;; (use-package! rainbow-delimiters
;;   :config
;;   (progn
;;     (defun @-enable-rainbow-delimiters ()
;;       (rainbow-delimiters-mode t))
;;     (add-hook 'prog-mode-hook '@-enable-rainbow-delimiters)))

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


;; centaur-tabs
(use-package! centaur-tabs
  :demand
  :config
  (setq centaur-tabs-style "bar"
        ;; centaur-tabs-height 30
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        ;;centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'over
        centaur-tabs-set-close-button nil
        x-underline-at-descent-line t
        centaur-tabs-gray-out-icons 'buffer
        )
  (centaur-tabs-mode t)
  (centaur-tabs-group-by-projectile-project)
  (centaur-tabs-enable-buffer-reordering)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-adjust-buffer-order t
        centaur-tabs-adjust-buffer-order 'right)
  ;;(centaur-tabs-headline-match)
  ;; (centaur-tabs-enable-buffer-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)

  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (setq centaur-tabs-cycle-scope 'tabs)
  )

;; treemacs
;;(after! treemacs
;;  (defvar treemacs-file-ignore-extensions '()
;;    "File extension which `treemacs-ignore-filter' will ensure are ignored")
;;  (defvar treemacs-file-ignore-globs '()
;;    "Globs which will are transformed to `treemacs-file-ignore-regexps' which `treemacs-ignore-filter' will ensure are ignored")
;;  (defvar treemacs-file-ignore-regexps '()
;;    "RegExps to be tested to ignore files, generated from `treeemacs-file-ignore-globs'")
;;  (defun treemacs-file-ignore-generate-regexps ()
;;    "Generate `treemacs-file-ignore-regexps' from `treemacs-file-ignore-globs'"
;;    (setq treemacs-file-ignore-regexps (mapcar 'dired-glob-regexp treemacs-file-ignore-globs)))
;;  (if (equal treemacs-file-ignore-globs '()) nil (treemacs-file-ignore-generate-regexps))
;;  (defun treemacs-ignore-filter (file full-path)
;;    "Ignore files specified by `treemacs-file-ignore-extensions', and `treemacs-file-ignore-regexps'"
;;    (or (member (file-name-extension file) treemacs-file-ignore-extensions)
;;        (let ((ignore-file nil))
;;          (dolist (regexp treemacs-file-ignore-regexps ignore-file)
;;            (setq ignore-file (or ignore-file (if (string-match-p regexp full-path) t nil)))))))
;;  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-filter))

;;(setq treemacs-file-ignore-extensions
;;      '(;; LaTeX
;;        "aux"
;;        "ptc"
;;        "fdb_latexmk"
;;        "fls"
;;        "synctex.gz"
;;        "toc"
;;        ;; LaTeX - glossary
;;        "glg"
;;        "glo"
;;        "gls"
;;        "glsdefs"
;;        "ist"
;;        "acn"
;;        "acr"
;;        "alg"
;;        ;; LaTeX - pgfplots
;;        "mw"
;;        ;; LaTeX - pdfx
;;        "pdfa.xmpi"
;;        ;; syncthing
;;        "stfolder"
;;        "stfolder (1)"
;;        ;; org-attach
;;        "attach"
;;        ))
;;(setq treemacs-file-ignore-globs
;;      '(;; LaTeX
;;        "*/_minted-*"
;;        ;; AucTeX
;;        "*/.auctex-auto"
;;        "*/_region_.log"
;;        "*/_region_.tex"))

(use-package! treemacs
  :config
  ;;(setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
  ;;      treemacs-deferred-git-apply-delay      0.5
  ;;      treemacs-directory-name-transformer    #'identity
  ;;      treemacs-display-in-side-window        t
  ;;      treemacs-eldoc-display                 t
  ;;      treemacs-file-event-delay              5000
  ;;      treemacs-file-extension-regex          treemacs-last-period-regex-value
  ;;      treemacs-file-follow-delay             0.2
  ;;      treemacs-file-name-transformer         #'identity
  ;;      treemacs-git-command-pipe              ""
  ;;      treemacs-goto-tag-strategy             'refetch-index
  ;;      treemacs-indentation                   2
  ;;      treemacs-indentation-string            " "
  ;;      treemacs-max-git-entries               5000
  ;;      treemacs-missing-project-action        'ask
  ;;      treemacs-move-forward-on-expand        nil
  ;;      treemacs-no-png-images                 nil
  ;;      treemacs-no-delete-other-windows       t
  ;;      treemacs-project-follow-cleanup        nil
  ;;      treemacs-position                      'left
  ;;      treemacs-read-string-input             'from-child-frame
  ;;      treemacs-recenter-distance             0.1
  ;;      treemacs-recenter-after-file-follow    nil
  ;;      treemacs-recenter-after-tag-follow     nil
  ;;      treemacs-recenter-after-project-jump   'always
  ;;      treemacs-recenter-after-project-expand 'on-distance
  ;;      treemacs-show-cursor                   nil
  ;;      treemacs-show-hidden-files             t
  ;;      treemacs-silent-filewatch              nil
  ;;      treemacs-silent-refresh                nil
  ;;      treemacs-space-between-root-nodes      t
  ;;      treemacs-tag-follow-cleanup            t
  ;;      treemacs-tag-follow-delay              1.5
  ;;      treemacs-user-mode-line-format         nil
  ;;      treemacs-user-header-line-format       nil
  ;;      treemacs-width                         35
  ;;      treemacs-workspace-switch-cleanup      nil)

  ;; (defvar treemacs-custom-snakemake-icon (all-the-icons-icon-for-file "images/name.python"))
  ;; (treemacs-define-custom-icon "smk" "snakefiles")

  (treemacs-define-custom-image-icon "~/.doom.d/images/logo-snake-22.png" "smk" "snakefiles")

  ;; (treemacs-define-custom-icon "images/snakemake.png" "smk" "snakefiles")

  ;; The default width and height of the icons is 22 pixels. If you are
  ;; using a Hi-DPI display, uncomment this to double the icon size.
  ;; (treemacs-resize-icons 44)

  ;;(treemacs-filewatch-mode t)
  ;;(treemacs-fringe-indicator-mode 'always)
  ;;:bind
  ;;(:map global-map
  ;; ("M-0"       . treemacs-select-window)
  ;; ("C-x t 1"   . treemacs-delete-other-windows)
  ;; ("C-x t t"   . treemacs)
  ;; ("C-x t B"   . treemacs-bookmark)
  ;; ("C-x t C-t" . treemacs-find-file)
  ;; ("C-x t M-t" . treemacs-find-tag))
  )

;; projectile
(after! projectile
  (setq projectile-project-search-path '("~/projects/" "~/documents/doraemon/" "~/documents/doraemon/org/blog"))
  (add-to-list 'projectile-globally-ignored-directories ".attach"))
