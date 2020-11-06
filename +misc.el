;;; ../projects/doom.d/+misc.el -*- lexical-binding: t; -*-

;; projectile
(setq projectile-project-search-path '("~/projects/" "~/documents/doraemon/" "~/documents/doraemon/org/blog"))


;; magit
(after! magit
  (setq magit-repository-directories '(("~/projects" . 2))
        magit-save-repository-buffers nil
        git-commit-style-convention-checks nil
        magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

  (magit-wip-after-apply-mode t)
  (magit-wip-before-change-mode t))


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


;; browser
(setq browse-url-generic-program "firefox")

;; proxy
;; (setq url-proxy-services
;;       '(("http" . "127.0.0.1:9910")
;;         ("https" . "127.0.0.1:9910")))
