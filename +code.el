;;; ../projects/doom.d/+code.el -*- lexical-binding: t; -*-

;; company
(after! company
  (setq
   company-idle-delay 0.2
   company-minimum-prefix-length 3
   company-show-numbers t))

;; conda
(require 'conda)
(setq conda-anaconda-home (concat zj-home ".conda/envs/bioenv"))
(setq conda-env-home-directory (concat zj-home ".conda/envs/bioenv"))
(setq conda-env-subdirectory "../")

;; rust
(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

;; format-all
;; clang-format
(after! format
  (set-formatter! 'clang-format
    '("clang-format"
      "-style={BasedOnStyle: LLVM, IndentWidth: 4, BreakBeforeBraces: Allman, SortIncludes: true}"
      ("-assume-filename=%S" (or buffer-file-name mode-result "")))
    ))

;; emacs-jupyter
(setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                     (:session . "py")))
