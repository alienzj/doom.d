;;; private/dap/config.el -*- lexical-binding: t; -*-
;; dap
(defun +my/dap-start ()
  (interactive)
  (dap-mode 1)
  (call-interactively #'dap-debug))

(add-hook! dap-mode-hook ((dap-tooltip-mode 1) (tooltip-mode 1)))

(after! dap-mode
  (setq dap-python-executable "python3")

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))
