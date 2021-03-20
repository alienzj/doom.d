;;; private/rss/config.el -*- lexical-binding: t; -*-

;; elfeed
(defun bjm/elfeed-show-all ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-all"))

(defun bjm/elfeed-show-daily ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-daily"))

(defun bjm/elfeed-show-emacs ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-emacs"))

(defun bjm/elfeed-show-research ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-research"))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  ;; (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  ;; (elfeed-db-save)
  (quit-window))

;; elfeed
(use-package! elfeed
  :config
  (setq
   rmh-elfeed-org-files (list (concat zj-org-dir "elfeed.org"))
   elfeed-search-filter "@10-week-ago")
  ;; (setq elfeed-show-entry-switch
  ;;       (lambda (b)
  ;;         (let ((w (split-window-right 50)))
  ;;           (set-window-buffer w b)
  ;;           (select-window w))))
  )

;; elfeed-dashboard
(use-package! elfeed-dashboard
  :config
  (setq elfeed-dashboard-file (concat zj-org-dir "elfeed-dashboard.org"))
  (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links)
  )

(defvar +rss-workspace-name "*RSS*")

;; (setenv "ALL_PROXY" "socks5://localhost:1080")

(defun +rss-setup-wconf (&optional inhibit-workspace)
  (when (and (featurep! :ui workspaces)
             (not inhibit-workspace))
    (+workspace-switch +rss-workspace-name 'auto-create))
  (let ((buffers (doom-buffers-in-mode 'elfeed-search-mode nil t)))
    (if buffers
        (ignore (switch-to-buffer (car buffers)))
      (delete-other-windows)
      (switch-to-buffer (doom-fallback-buffer))
      t)))

;;;###autoload
(defun =rss+ (&optional inhibit-workspace)
  (interactive "P")
  (+rss-setup-wconf inhibit-workspace)
  (cond ((doom-buffers-in-mode 'elfeed-search-mode (doom-buffer-list) t)
         (message "elfeed buffers are already open"))
        ((call-interactively #'elfeed))))

;;;###autoload
(defun +rss/quit ()
  (interactive)
  (when (and (featurep! :ui workspaces)
             (+workspace-switch +rss-workspace-name))
    (mapc #'kill-buffer
          (doom-buffers-in-mode '(elfeed-search-mode elfeed-show-mode)
                                (buffer-list) t))
    (+workspace/delete +rss-workspace-name)))

;; (defun browse-url-eww (url &optional _)
;;   (interactive)
;;   (eww url))

;; (add-hook 'elfeed-show-mode-hook
;;           (lambda ()
;;             (setq-local browse-url-browser-function #'browse-url-eww)))

;; (add-hook 'eww-mode-hook
;;           (lambda ()
;;             (setq-local url-gateway-method 'socks)
;;             (setq-local socks-server '("Default server" "127.0.0.1" 1080 5))))

(require 'eaf)
(map! (:when (featurep! :app rss)
       :map elfeed-search-mode-map
       :n "RET" #'eaf-elfeed-open-url
       :n "r" #'bjm/elfeed-show-all
       :n "D" #'bjm/elfeed-show-daily
       :n "E" #'bjm/elfeed-show-emacs
       :n "R" #'bjm/elfeed-show-research
       :n "q" #'bjm/elfeed-save-db-and-bury
       :n "gu" #'elfeed-update
       :n "c" #'elfeed-search-clear-filter
       :n [remap elfeed-kill-buffer] #'+rss/quit )
      :leader "on" '=rss+)
