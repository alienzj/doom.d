;;; private/lsp/config.el -*- lexical-binding: t; -*-

;; company
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

(setq read-process-output-max (* 1024 1024))
(setq lsp-idle-delay 0.500)
;; lsp
;; (setq lsp-enable-text-document-color nil)
;; (setq lsp-enable-semantic-highlighting nil)
;; (setq lsp-enable-symbol-highlighting nil)

(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"))

(setq lsp-enable-symbol-highlighting nil)
(setq lsp-enable-file-watchers nil)
(setq lsp-log-io nil)
;; (setq lsp-print-performance t)

(with-eval-after-load 'lsp-mode
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace))

;; (setq lsp-ido-show-symbol-kind nil
;;       lsp-ido-show-symbol-filename nil)

;; (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-tramp-connection "<binary name (e. g. pyls, rls)>")
;;                      :major-modes '(python-mode)
;;                      :remote? t
;;                      :server-id 'pyls-remote))
