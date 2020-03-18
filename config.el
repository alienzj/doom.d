;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq user-full-name "alienzj"
      user-mail-address "alienchuj@gmail.com"
      epa-file-encrypt-to user-mail-address)

;; enable auto-completion
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

(setq doom-font (font-spec :family "Monospace" :size 23)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 23)
      doom-unicode-font (font-spec :family "Noto Sans")
      doom-big-font (font-spec :family "Noto Sans" :size 28))

;;(setq doom-theme 'doom-solarized-light)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(setq doom-themes-treemacs-theme "doom-colors")

;;(doom-themes-visual-bell-config)
;;(doom-themes-neotree-config)

;;(setq doom-theme 'doom-solarized-dark)
;;(setq doom-theme 'doom-molokai)
;;(after! doom-themes
;;  (add-hook 'doom-load-theme-hook #'doom-themes-org-config))

;;(setq all-the-icons-scale-factor 1.0)
;;(doom-themes-treemacs-config)
;;(doom-themes-org-config)
;;(setq doom-modeline-height 4)
;;(setq doom-modeline-bar-width 2)
(setq doom-modeline-icon t)

(setq magit-repository-directories '(("~/projects" .2))
      magit-save-repository-buffers nil
      magit-inhibit-save-previous-winconf t)

(setq
 ;; configuration for bibtex-completion, helm-bibtex, ivy-bibtex
 bibtex-completion-bibliography '("~/documents/doraemon/org/ref/ref.bib")
 ;; specify where PDFs can be found
 bibtex-completion-library-path "~/documents/doraemon/org/ref/pdf"
 bibtex-completion-pdf-field "File"
 ;; notes
 bibtex-completion-notes-path "~/documents/doraemon/org/ref/ref.org"

 org-directory "~/documents/doraemon/org"

 reftex-default-bibliography '("~/documents/doraemon/org/ref/ref.bib")
 ;; configuration for org-ref
 org-ref-default-bibliography '("~/documents/doraemon/org/ref/ref.bib")
 org-ref-pdf-directory "~/documents/doraemon/org/ref/pdf"
 org-ref-bibliography-notes "~/documents/doraemon/org/ref/ref.org")

;; open pdf with system pdf viewer
(setq bibtex-completion-pdf-open-function
      (lambda (fqpath)
        (start-process "open" "*open" "open" fqpath)))

(setq-default org-download-image-dir "~/documents/doraemon/org/images")


(after! org
  (add-to-list 'org-modules 'org-habit t))

(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/documents/doraemon/org")
(setq deft-recursive t)

;;(setq +lookup-open-url-fn #'eww)

(setq ddragon-dir "~/documents/database/lol")

(defun xah-open-in-vscode ()
  "Open current file or dir in vscode.
Version 2019-11-04"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name) default-directory )))
    (cond
     ((string-equal system-type "darwin")
      (shell-command (format "open -a Visual\\ Studio\\ Code.app \"%s\"" $path)))
     ((string-equal system-type "windows-nt")
      (shell-command (format "Code \"%s\"" $path)))
     ((string-equal system-type "gnu/linux")
      (shell-command (format "code \"%s\"" $path))))))

(setq anki-editor-create-decks t)

;;(setq clang-format-style-option "llvm")
;;(setq tab-width 4)

;; *** fringe
(defun remove-fringes ()
  (set-window-fringes nil 0 0)
  (set-window-margins nil 0 0))

(after! magit
  (add-hook 'magit-post-display-buffer-hook #'remove-fringes t)
  (add-hook! magit-popup-mode-hook #'remove-fringes))

(after! treemacs
  (add-hook 'treemacs-select-hook #'remove-fringes))

;;(require 'conda)
;;(setq conda-anaconda-home "~/.conda/envs/bioenv")
;;(conda-env-initialize-interactive-shells)
;;(conda-env-initialize-eshell)
;;(conda-env-autoactivate-mode t)


;;(dap-mode 1)
;;(dap-ui-mode 1)
;;(dap-tooltip-mode 1)
;;(tooltip-mode 1)
;;(require 'dap-gdb-lldb)
;;(require 'dap-python)

;;(setq tramp-default-method "ssh")
;;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(add-hook! python-mode
  (setq python-shell-interpreter "ipython"))

(setq rustic-lsp-server 'rust-analyzer)

;;(def-package! calibre-mode
;;  :config
;;  (setq sql-sqlite-program "/usr/bin/sqlite3")
;;  (setq calibre-root-dir (expand-file-name "~/documents/doraemon/books/calibre"))
;;  (setq calibre-db (concat calibre-root-dir "/metadata.db")))

;;(setq debug-on-error t)

(defun colorit ()
  (interactive)
  (rainbow-delimiters-mode)
  (rainbow-identifiers-mode))

(add-hook 'rustic-mode-hook #'colorit t)

(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)

(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-saturation 72  ;80 ;125
      rainbow-identifiers-cie-l*a*b*-lightness 72   ;45 ;100
      ;; override theme faces
      rainbow-identifiers-faces-to-override '(highlight-quoted-symbol
                                              font-lock-keyword-face
                                              font-lock-function-name-face
                                              font-lock-variable-name-face))
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)

(add-hook 'completion-list-mode-hook #'hide-mode-line-mode)
;;(add-hook 'neotree-mode-hook #'hide-mode-line-mode)

(defun my-doom-modeline--font-height ()
  "Calculate the actual char height of the mode-line."
  (+ (frame-char-height) 6))
(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(defun ding-ding-ding ()
  "Ding whatever the settings are."
  (interactive)
  (require 'cl-macs)
  (let ((ring-bell-function nil)
        (visible-bell nil))
    (loop repeat 100 do (ding) (other-frame 0) (sit-for 1))))

(defun zj-pomodoro ()
  "Ding after a pomodoro time"
  (interactive)
  (run-at-time "25 min" nil 'ding-ding-ding))

(defun save-firefox-session ()
  "Reads firefox current session and coverts it to org-mode chunk."
  (interactive)
  (save-excursion
    (let* ((path "~/.mozilla/firefox/6eb49djq.default-release/sessionstore-backups/recovery.jsonlz4")
           (cmd (concat "lz4jsoncat " path " | grep -oP '\"(http:.+?)\"|\"(https:.+?)\"' | sed 's/\"//g' | sort | uniq "))
           (ret (shell-command-to-string cmd)))
      (insert
       (concat
        "* "
        (format-time-string "[%Y-%m-%d %H:%M:%S]")
        "\n"
        (mapconcat 'identity
                   (cl-reduce (lambda (lst x)
                                (if (and x (not (string= "" x)))
                                    (cons (concat "  - " x) lst)
                                  lst))
                              (split-string ret "\n")
                              :initial-value (list))
                   "\n"))))))

(defun restore-firefox-session ()
  "Restore session, by openning each link in list with (browse-url).
Make sure to put cursor on date heading that contains list of urls."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (looking-at "^\\*")
      (forward-line 1)
      (while (looking-at "^[ ]+-[ ]+\\(http.?+\\)$")
        (let* ((ln (thing-at-point 'line t))
               (ln (replace-regexp-in-string "^[ ]+-[ ]+" "" ln))
               (ln (replace-regexp-in-string "\n" "" ln)))
          (browse-url ln))
        (forward-line 1)))))

;; centaur-tabs configuration
(use-package centaur-tabs
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-set-modified-marker t
        centaur-tabs-show-navigation-buttons t
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t)
  (centaur-tabs-headline-match)
  ;; (setq centaur-tabs-gray-out-icons 'buffer)
  ;; (centaur-tabs-enable-buffer-reordering)
  ;; (setq centaur-tabs-adjust-buffer-order t)
  (centaur-tabs-mode t)
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

(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))

(use-package aqi
  :config (setq aqi-api-key ""
                aqi-use-cache t
                aqi-report "Shenzhen"
                aqi-city-aqi "Shenzhen"))
