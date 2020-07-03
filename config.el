;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; user information
(setq user-full-name "alienzj"
      user-mail-address "alienchuj@gmail.com"
      epa-file-encrypt-to user-mail-address)


;; enable auto-completion
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)


;; doom ui
(setq doom-font (font-spec :family "Monospace" :size 23)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 23)
      doom-unicode-font (font-spec :family "Noto Sans")
      doom-big-font (font-spec :family "Noto Sans" :size 28)

      doom-themes-enable-bold t
      doom-themes-enable-italic t
      doom-themes-treemacs-theme "doom-colors"
      ;;doom-theme 'doom-solarized-dark
      ;;doom-theme 'doom-molokai)
      ;;all-the-icons-scale-factor 1.0
      ;;doom-modeline-height 4
      ;;doom-modeline-bar-width 2
      doom-modeline-icon t)

(add-hook 'completion-list-mode-hook #'hide-mode-line-mode)
;;(add-hook 'neotree-mode-hook #'hide-mode-line-mode)

(defun my-doom-modeline--font-height ()
  "Calculate the actual char height of the mode-line."
  (+ (frame-char-height) 6))
(advice-add #'doom-modeline--font-height :override #'my-doom-modeline--font-height)

(defun remove-fringes ()
  (set-window-fringes nil 0 0)
  (set-window-margins nil 0 0))


;; treemacs
(after! treemacs
  (add-hook 'treemacs-select-hook #'remove-fringes))


;; magit
(setq magit-repository-directories '(("~/projects" .2))
      magit-save-repository-buffers nil
      magit-inhibit-save-previous-winconf t)

(after! magit
  (add-hook 'magit-post-display-buffer-hook #'remove-fringes t)
  (add-hook! magit-popup-mode-hook #'remove-fringes))


;; org, org-ref, org-noter, bibtex
(after! org
  (add-to-list 'org-modules 'org-habit t))

(setq bibtex-completion-bibliography '("~/documents/doraemon/org/ref/ref.bib")
      bibtex-completion-library-path "~/documents/doraemon/org/ref/pdf"
      bibtex-completion-pdf-field "File"
      bibtex-completion-notes-path "~/documents/doraemon/org/note/note.org"

      org-directory "~/documents/doraemon/org"
      org-download-image-dir "~/documents/doraemon/org/images"

      reftex-default-bibliography '("~/documents/doraemon/org/ref/ref.bib")
      org-ref-default-bibliography '("~/documents/doraemon/org/ref/ref.bib")
      org-ref-pdf-directory "~/documents/doraemon/org/ref/pdf"
      org-ref-bibliography-notes "~/documents/doraemon/org/note/note.org"

      org-noter-default-notes-file-names '("note.org")
      org-noter-notes-search-path '("~/documents/doraemon/org/note")
      org-noter-separate-notes-from-heading t)

;; open pdf with system pdf viewer
(setq bibtex-completion-pdf-open-function
      (lambda (fqpath)
        (start-process "open" "*open" "open" fqpath)))

;; org-ref, org-noter function
;; https://write.as/dani/notes-on-org-noter
(defun org-ref-noter-at-point ()
  "Open the pdf for bibtex key under point if it exists."
  (interactive)
  (let* ((results (org-ref-get-bibtex-key-and-file))
         (key (car results))
         (pdf-file (funcall org-ref-get-pdf-filename-function key)))
    (if (file-exists-p pdf-file)
        (progn
          (find-file-other-window pdf-file)
          (org-noter))
      (message "no pdf found for %s" key))))


;; deft
(setq deft-extensions '("txt" "tex" "org")
      deft-directory "~/documents/doraemon/org"
      deft-recursive t)


;; elfeed
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))


;; lookup
;;(setq +lookup-open-url-fn #'eww)


;; ddragon
(setq ddragon-dir "~/documents/database/lol")


;; vscode
(defun xah-open-in-vscode ()
  "Open current file or dir in vscode. Version 2019-11-04"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name) default-directory )))
    (cond
     ((string-equal system-type "darwin")
      (shell-command (format "open -a Visual\\ Studio\\ Code.app \"%s\"" $path)))
     ((string-equal system-type "windows-nt")
      (shell-command (format "Code \"%s\"" $path)))
     ((string-equal system-type "gnu/linux")
      (shell-command (format "code \"%s\"" $path))))))


;; anki-editor
(setq anki-editor-create-decks t)


;; conda
;;(require 'conda)
;;(setq conda-anaconda-home "~/.conda/envs/bioenv")
;;(conda-env-initialize-interactive-shells)
;;(conda-env-initialize-eshell)
;;(conda-env-autoactivate-mode t)


;; tramp
;;(setq tramp-default-method "ssh")
;;(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))


;; rust
(setq rustic-lsp-server 'rust-analyzer)


;; calibre-mode
;;(def-package! calibre-mode
;;  :config
;;  (setq sql-sqlite-program "/usr/bin/sqlite3"
;;        calibre-root-dir (expand-file-name "~/documents/doraemon/books/calibre")
;;        calibre-db (concat calibre-root-dir "/metadata.db")))


;; debug
;;(setq debug-on-error t)


;; rainbow color
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


;; nyan
(setq nyan-wavy-trail t)
(setq nyan-animate-nyancat t)
(nyan-mode)


;; pomodoro
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


;; firefox
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


;; centaur-tabs
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


;; aqi, air quality
;;(use-package! aqi
;;  :config (setq aqi-api-key ""
;;                aqi-use-cache t
;;                aqi-report "Shenzhen"
;;                aqi-city-aqi "Shenzhen"))

;;https://github.com/lassik/emacs-format-all-the-code/issues/76
;; ESS, R
(setenv "R_HOME" nil)
