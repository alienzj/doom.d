
;;; PRIVATE/eaf/config.el -*- lexical-binding: t; -*-

(use-package! eaf
  :init
  (map! :leader
        :desc "eaf open history" "eh" 'eaf-open-browser-with-history
        :desc "eaf open terminal" "et" 'eaf-open-terminal
        :desc "eaf open rss" "er" 'eaf-open-rss-reader)
  :config
  (use-package! ctable)
  (use-package! deferred)
  (use-package! epc)

  ;; (setq eaf-proxy-type "socks5"
  ;;       eaf-proxy-host "127.0.0.1"
  ;;       eaf-proxy-port "9909")
  ;;
  ;; (eaf-setq eaf-browser-aria2-proxy-host "127.0.0.1")
  ;; (eaf-setq eaf-browser-aria2-proxy-port "9910")

  (setq browse-url-browser-function 'eaf-open-browser)
  (defalias 'browse-web #'eaf-open-browser)
  (eaf-setq eaf-browser-default-zoom "1.5")
  (eaf-setq eaf-browser-dark-mode "false")
  (eaf-setq eaf-browser-font-family "Sans Serif")
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-setq eaf-browser-download-path "~/downloads/eaf")
  (eaf-setq eaf-browser-chrome-history-file "~/.config/chromium/Default/History")

  (eaf-setq eaf-terminal-dark-mode "true")
  (eaf-setq eaf-terminal-font-size "18")
  (eaf-setq eaf-terminal-font-family "monospace")

  (eaf-setq eaf-mindmap-dark-mode "true") ; default option

  ;; (eaf-setq eaf-find-file-ext-blacklist '("pdf"))
  ;; (setq eaf-find-file-ext-blacklist (list eaf-pdf-extension-list))
  ;; (eaf-setq eaf-pdf-dark-mode "ignore")
  ;; (eaf-setq eaf-pdf-dark-mode "false")
  ;; (eaf-setq eaf-pdf-default-zoom "0.8")
  ;; (eaf-setq eaf-pdf-dark-exclude-image "true")
  ;; (eaf-setq eaf-pdf-scroll-ratio "0.05")

  (advice-remove #'find-file #'eaf--find-file-advisor)
  (advice-remove #'dired-find-file #'eaf--dired-find-file-advisor)
  (advice-remove #'dired-find-alternate-file #'eaf--dired-find-file-advisor)

  (eaf-setq eaf-camera-save-path "~/videos/eaf")

  (require 'eaf-evil)
  (define-key key-translation-map (kbd "SPC")
    (lambda (prompt)
      (if (derived-mode-p 'eaf-mode)
          (pcase eaf--buffer-app-name
            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
                           (kbd "SPC")
                         (kbd eaf-evil-leader-key)))
            ("pdf-viewer" (kbd eaf-evil-leader-key))
            ("image-viewer" (kbd eaf-evil-leader-key))
            (_  (kbd "SPC")))
        (kbd "SPC"))))
  )

;; snails
(use-package! fuz)
(use-package! snails
  :commands (snails snails-search-point)
  :init
  (map! "s-y" #'snails-search-point
        "s-a" #'snails)
  :config
  (setq snails-show-with-frame t)
  ;; (add-hook 'snails-mode-hook #'centaur-tabs-local-mode)
  (add-to-list 'evil-emacs-state-modes 'snails-mode))


;; from TeX-pdf-tools-sync-view
;;;###autoload
(defun TeX-eaf-sync-view()
  (unless (fboundp 'eaf-open)
    (error "EAF is not available!"))
  (let* ((pdf (TeX-active-master (TeX-output-extension)))
         (url (expand-file-name pdf))
         (app-name "pdf-viewer")
         (exists-eaf-buffer)
         (eaf-buffer-window))
    (catch 'found-match-buffer
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (when (equal major-mode 'eaf-mode)
          (when (and (string= buffer-url url)
                     (string= buffer-app-name app-name))
            (setq exists-eaf-buffer buffer)
            (setq eaf-buffer-window (get-buffer-window exists-eaf-buffer))
            (throw 'found-match-buffer t)))))
    (if (and exists-eaf-buffer eaf-buffer-window)
        (pop-to-buffer exists-eaf-buffer)
      (eaf-open url app-name "--synctex_on=True"))))

(eval-after-load "tex"
  '(progn
     (add-to-list 'TeX-view-program-list '("eaf" TeX-eaf-sync-view))
     (add-to-list 'TeX-view-program-selection '(output-pdf "eaf"))
     ))
