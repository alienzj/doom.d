;;; ../projects/doom.d/+prog.el -*- lexical-binding: t; -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COMPANY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! company
  (setq company-idle-delay 0.2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FLYCHECK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar cspell-base-program "cspell")
(defvar cspell-config-file-path (concat "'" (expand-file-name  "~/.cspell.json") "'"))
(defvar cspell-args (string-join `("--config" ,cspell-config-file-path) " "))
(defun cspell-check-buffer ()
  (interactive)
  (if cspell-base-program
      (let* ((file-name (concat "'" (file-name-nondirectory (buffer-file-name)) "'"))
             (command (string-join `(,cspell-base-program ,cspell-args ,file-name) " ")))
        (compilation-start command 'grep-mode))
    (message "Cannot find cspell, please install with `npm install -g cspell`")
    ))

(defun cspell-check-HEAD ()
  (interactive)
  (if cspell-base-program
      (let* ((project-root (doom-project-root))
             (default-directory
               (if (string-match-p "av/detection" project-root)
                   (expand-file-name "~/av")
                 project-root))
             (command (string-join `("git diff --name-only HEAD | xargs -I{}" ,cspell-base-program ,cspell-args "'{}'") " ")))
        (compilation-start command 'grep-mode))
    (message "Cannot find cspell, please install with `npm install -g cspell`")))

;; (use-package! wucuo
;;   :defer t
;;   :init
;;   (add-hook! (js2-mode rjsx-mode go-mode c-mode c++-mode) #'wucuo-start))


(after! flycheck
  (setq-default flycheck-disabled-checkers
                '(
                  javascript-jshint handlebars
                  json-jsonlist json-python-json
                  c/c++-clang c/c++-cppcheck c/c++-gcc
                  python-pylint python-pycompile
                  ))

  ;; customize flycheck temp file prefix
  (setq-default flycheck-temp-prefix ".flycheck")

  ;; ======================== JS & TS ========================
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (after! tide
    (flycheck-add-next-checker 'javascript-eslint '(t . javascript-tide) 'append)
    (flycheck-add-next-checker 'javascript-eslint '(t . jsx-tide) 'append)
    (flycheck-add-next-checker 'typescript-tslint '(t .  typescript-tide) 'append)
    (flycheck-add-next-checker 'javascript-eslint '(t . tsx-tide) 'append))

  ;; ======================== Python ========================
  (require 'flycheck-mypy)

  ;; ======================== CC ========================
  (require 'flycheck-google-cpplint)
  (setq flycheck-c/c++-googlelint-executable "cpplint")
  (flycheck-add-next-checker 'c/c++-gcc '(t . c/c++-googlelint))

  (setq flycheck-c/c++-gcc-executable "gcc-7"
        flycheck-gcc-include-path '("/usr/local/inclue"))

  (add-hook! c++-mode-hook
    (setq flycheck-gcc-language-standard "c++11"
          flycheck-clang-language-standard "c++11"))
  )

(defun disable-flycheck-mode ()
  (flycheck-mode -1))
;; (add-hook! (emacs-lisp-mode) 'disable-flycheck-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! bazel-mode
  :defer t
  :commands bazel-mode
  :init
  (add-to-list 'auto-mode-alist '("BUILD\\(\\.bazel\\)?\\'" . bazel-mode))
  (add-to-list 'auto-mode-alist '("WORKSPACE\\'" . bazel-mode))
  :config
  ;; disable format-all becuase it doesn't sort BUILD list variables
  (setq bazel-mode-buildifier-before-save t)
  (appendq! +format-on-save-enabled-modes '(bazel-mode)))

(add-to-list 'auto-mode-alist '("\\.inl\\'" . +cc-c-c++-objc-mode))
(add-to-list 'auto-mode-alist '("\\.inc\\'" . +cc-c-c++-objc-mode))

(after! cc-mode
  (c-add-style
   "my-cc" '("user"
             (c-basic-offset . 2)
             (c-offsets-alist
              . ((innamespace . 0)
                 (access-label . -)
                 (case-label . 0)
                 (member-init-intro . +)
                 (topmost-intro . 0)
                 (arglist-cont-nonempty . +)))))
  (setq c-default-style "my-cc")

  (setq-default c-basic-offset 2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PYTHON
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! python
  (setq python-indent-offset 4
        python-shell-interpreter "python3"
        pippel-python-command "python3"
        conda-env-home-directory (concat zj-home ".conda/envs/bioenv")
        importmagic-python-interpreter "python3"
        flycheck-python-pylint-executable "pylint"
        flycheck-python-flake8-executable "flake8")

  ;; if you use pyton2, then you could comment the following 2 lines
  ;; (setq python-shell-interpreter "python2"
  ;;       python-shell-interpreter-args "-i")

  ;; ignore some linting info
  (if (featurep! :tools lsp)
      (setq lsp-pyls-plugins-pycodestyle-ignore  [ "E501" ]
            lsp-pyls-plugins-pylint-args [ "--errors-only" ]))
  )


(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"))

(use-package! py-isort
  :defer t
  :init
  (define-minor-mode python-isort-autosave-mode
    "Isort autosave mode."
    :lighter " Isort"
    :global nil
    (when (not (derived-mode-p 'python-mode))
      (error "Isort only works with Python buffers"))
    (if python-isort-autosave-mode
        (add-hook! 'before-save-hook :local #'py-isort-before-save)
      (remove-hook! 'before-save-hook :local #'py-isort-before-save)))

  (add-hook! 'python-mode-hook #'python-isort-autosave-mode))


;; (use-package! importmagic
;;   :defer t
;;   :hook (python-mode . importmagic-mode)
;;   :commands (importmagic-fix-imports importmagic-fix-symbol-at-point)
;;   :config
;;   (dolist (func '(importmagic-fix-imports importmagic-fix-symbol-at-point))
;;     (advice-add func :before #'revert-buffer-no-confirm)))


(after! pipenv
  (setq pipenv-with-projectile t)
  ;; Override pipenv--clean-response to trim color codes
  (defun pipenv--clean-response (response)
    "Clean up RESPONSE from shell command."
    (replace-regexp-in-string "\n\\[0m$" "" (s-chomp response)))

  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(pipenv-activate pipenv-deactivate))
    (advice-add func :after #'reset-flycheck)))


(after! conda
  ;; restart flycheck-mode after env activate and deactivate
  (dolist (func '(conda-env-activate conda-env-deactivate))
    (advice-add func :after #'reset-flycheck)))


;; For pytest-mode
(set-evil-initial-state! '(comint-mode) 'normal)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JS, WEB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package! import-js
  :defer t
  :init
  (add-hook! (js2-mode rjsx-mode) (run-import-js))
  (add-hook! (js2-mode rjsx-mode)
    (add-hook 'after-save-hook #'import-js-fix nil t)))
(advice-add '+javascript|cleanup-tide-processes :after 'kill-import-js)


(after! web-mode
  (web-mode-toggle-current-element-highlight)
  (web-mode-dom-errors-show))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (after! go-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LISPY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! lispy
  (remove-hook! '+format-on-save-enabled-modes #'emacs-lisp-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP & DAP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use format-all by default
(setq +format-with-lsp nil)

(after! lsp-mode
  (setq lsp-print-io nil)
  (dolist (dir '("[/\\\\]\\.ccls-cache$"
                 "[/\\\\]\\.mypy_cache$"
                 "[/\\\\]\\.pytest_cache$"
                 "[/\\\\]\\.cache$"
                 "[/\\\\]\\.clwb$"
                 "[/\\\\]_build$"
                 "[/\\\\]__pycache__$"
                 "[/\\\\]bazel-bin$"
                 "[/\\\\]bazel-code$"
                 "[/\\\\]bazel-genfiles$"
                 "[/\\\\]bazel-out$"
                 "[/\\\\]bazel-testlogs$"
                 "[/\\\\]third_party$"
                 "[/\\\\]third-party$"
                 ))
    (push dir lsp-file-watch-ignored))
  )


(after! lsp-ui
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-include-signature t
        lsp-ui-doc-max-height 15
        lsp-ui-doc-max-width 100
        lsp-ui-doc-position 'at-point))


(use-package lsp-docker
  :defer t
  :commands lsp-docker-init-clients
  :config
  (defvar lsp-docker-client-packages
    '(lsp-css lsp-clients lsp-bash lsp-go lsp-pyls lsp-html lsp-typescript
              lsp-terraform lsp-cpp))

  (defvar lsp-docker-client-configs
    (list
     (list :server-id 'bash-ls :docker-server-id 'bashls-docker :server-command "bash-language-server start")
     (list :server-id 'clangd :docker-server-id 'clangd-docker :server-command "ccls")
     (list :server-id 'css-ls :docker-server-id 'cssls-docker :server-command "css-languageserver --stdio")
     (list :server-id 'dockerfile-ls :docker-server-id 'dockerfilels-docker :server-command "docker-langserver --stdio")
     (list :server-id 'gopls :docker-server-id 'gopls-docker :server-command "gopls")
     (list :server-id 'html-ls :docker-server-id 'htmls-docker :server-command "html-languageserver --stdio")
     (list :server-id 'pyls :docker-server-id 'pyls-docker :server-command "pyls")
     (list :server-id 'ts-ls :docker-server-id 'tsls-docker :server-command "typescript-language-server --stdio")))

  ;; (lsp-docker-init-clients
  ;;  :path-mappings `((,(file-truename "~/av") . "/code"))
  ;;  ;; :docker-image-id "my-lsp-docker-container:1.0"
  ;;  :client-packages '(lsp-pyls)
  ;;  :client-configs lsp-docker-client-configs)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEBUG & RUN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! quickrun
  (quickrun-add-command "c++/c1z"
    '((:command . "clang++")
      (:exec    . ("%c -std=c++1z %o -o %e %s"
                   "%e %a"))
      (:remove  . ("%e")))
    :default "c++"))


(after! realgud (advice-remove #'realgud:terminate #'+debugger--cleanup-after-realgud-a))


(defun +my/dap-start ()
  (interactive)
  (dap-mode 1)
  (call-interactively #'dap-debug))

(add-hook! dap-mode-hook ((dap-tooltip-mode 1) (tooltip-mode 1)))

(after! dap-mode
  (setq dap-python-executable "python3")

  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

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

;; ccls
;; https://github.com/MaskRay/Config/blob/master/home/.config/doom/modules/private/my-cc/config.el
(after! cc-mode
  ;; https://github.com/radare/radare2
  (c-add-style
   "radare2"
   '((c-basic-offset . 4)
     (indent-tabs-mode . t)
     (c-auto-align-backslashes . nil)
     (c-offsets-alist
      (arglist-intro . ++)
      (arglist-cont . ++)
      (arglist-cont-nonempty . ++)
      (statement-cont . ++)
      )))
  (c-add-style
   "my-cc" '("user"
             (c-basic-offset . 2)
             (c-offsets-alist
              . ((innamespace . 0)
                 (access-label . -)
                 (case-label . 0)
                 (member-init-intro . +)
                 (topmost-intro . 0)
                 (arglist-cont-nonempty . +)))))
  (setq c-default-style "my-cc")
  (add-hook 'c-mode-common-hook
            (lambda ()
              ;; TODO work around https://github.com/hlissner/doom-emacs/issues/1006
              ;; (when (and buffer-file-name (string-match-p "binutils\\|glibc" buffer-file-name))
              ;;   (setq tab-width 8)
              ;;   (c-set-style "gnu"))
              (setq flymake-diagnostic-functions '(lsp--flymake-backend t))
              (modify-syntax-entry ?_ "w")
              ))

  (add-to-list 'auto-mode-alist '("\\.inc\\'" . +cc-c-c++-objc-mode))

  (map!
   :map (c-mode-map c++-mode-map)
   :n "C-h" (λ! (ccls-navigate "U"))
   :n "C-j" (λ! (ccls-navigate "R"))
   :n "C-k" (λ! (ccls-navigate "L"))
   :n "C-l" (λ! (ccls-navigate "D"))
   (:leader
    :n "=" #'clang-format-region
    )
   (:localleader
    :n "a" #'ccls/references-address
    :n "f" #'ccls/references-not-call
    :n "lp" #'ccls-preprocess-file
    :n "lf" #'ccls-reload
    :n "m" #'ccls/references-macro
    :n "r" #'ccls/references-read
    :n "w" #'ccls/references-write
    :desc "breakpoint"
    :n "db" (lambda ()
              (interactive)
              (evil-open-above 1)
              (insert "volatile static int z=0;while(!z)asm(\"pause\");")
              (evil-normal-state))
    :n "dd" #'realgud:gdb
    ))
  )


(after! ccls
  ;; ;; :hook ((c-mode-local-vars c++-mode-local-vars objc-mode-local-vars) . +ccls|enable)
  ;; :config
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  (setq ccls-sem-highlight-method 'font-lock)
  (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  (ccls-use-default-rainbow-sem-highlight)
  ;; https://github.com/maskray/ccls/blob/master/src/config.h
  (setq
   ccls-initialization-options
   `(:clang
     (:excludeArgs
      ;; Linux's gcc options. See ccls/wiki
      ["-falign-jumps=1" "-falign-loops=1" "-fconserve-stack" "-fmerge-constants" "-fno-code-hoisting" "-fno-schedule-insns" "-fno-var-tracking-assignments" "-fsched-pressure"
       "-mhard-float" "-mindirect-branch-register" "-mindirect-branch=thunk-inline" "-mpreferred-stack-boundary=2" "-mpreferred-stack-boundary=3" "-mpreferred-stack-boundary=4" "-mrecord-mcount" "-mindirect-branch=thunk-extern" "-mno-fp-ret-in-387" "-mskip-rax-setup"
       "--param=allow-store-data-races=0" "-Wa arch/x86/kernel/macros.s" "-Wa -"]
      :extraArgs []
      :pathMappings ,+ccls-path-mappings)
     :completion
     (:include
      (:blacklist
       ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
        "^/usr/(local/)?include/c\\+\\+/v1/"
        ]))
     :index (:initialBlacklist ,+ccls-initial-blacklist :parametersInDeclarations :json-false :trackDependency 1)))

  (after! projectile
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

  (evil-set-initial-state 'ccls-tree-mode 'emacs)
  )

(use-package! tablegen-mode
  :load-path "~/projects/llvm-project/llvm/utils/emacs"
  :defer t
  :mode "\\.td\\'"
  :config
  (map!
   :map tablegen-mode-map
   (:leader
     :n "=" #'clang-format-region
     )))
