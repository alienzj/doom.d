;;; private/lsp/config.el -*- lexical-binding: t; -*-

;; company
(after! company
  (setq company-idle-delay 0.2))



;; lsp
;; (setq lsp-enable-text-document-color nil)
;; (setq lsp-enable-semantic-highlighting nil)
;; (setq lsp-enable-symbol-highlighting nil)

(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"))

(setq lsp-enable-symbol-highlighting nil)
