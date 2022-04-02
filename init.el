;;; init.el -*- lexical-binding: t; -*-

(setq zj-home (concat "/home/" user-login-name "/")
      zj-project-dir (concat zj-home "projects/")
      zj-document-dir (concat zj-home "documents/")
      zj-doraemon-dir (concat zj-document-dir "doraemon/")
      zj-org-dir (concat zj-doraemon-dir "org/")
      )

(cond
 ((string= user-login-name "alienzj")
  (setq zj-blog-dir (concat zj-org-dir "blog/alienzj.github.io/"))
  )

 ((string= user-login-name "zhujie")
  (setq  zj-blog-dir (concat zj-org-dir "blog/ohmeta.github.io/"))
  )
 )

;; (setq package-archives
;;       '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;         ("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;;         ("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))

(doom!

       :input
       chinese

       :completion
       (company +auto +childframe)
       ;;helm
       ;;ido
       (ivy +childframe +icons)
       ;+fuzzy
       (vertico +icons)

       :ui
       ;;deft
       doom
       doom-dashboard
       doom-quit
       ;(emoji +unicode)
       ;;fill-column
       hl-todo
       ;;hydra
       ;;indent-guides
       ;;minimap
       modeline
       nav-flash
       ;;neotree
       ophints
       (popup +defaults)
       ;;pretty-code
       tabs
       treemacs
       tree-sitter
       ;;unicode
       vc-gutter
       vi-tilde-fringe
       (window-select
        +switch-window
        +numbers)
       workspaces
       zen

       :editor
       (evil +everywhere)
       file-templates
       fold
       ;;objed
       format
       ;;lispy
       multiple-cursors
       ;;parinfer
       rotate-text
       snippets
       ;;word-wrap

       :checkers
       (syntax +childframe)
       ;spell
       ;grammar

       :emacs
       dired
       electric
       vc
       ibuffer
       (undo +tree)

       :term
       eshell
       ;;shell
       ;;term
       vterm

       :tools
       ;;ansible
       (debugger +lsp)
       ;;direnv
       docker
       ;;editorconfig
       ;;ein
       (eval +overlay)
       ;;gist
       (lookup
        +dictionary
        +docsets)
       lsp
       magit
       ;;make
       ;;(pass +auth)
       pdf
       ;;prodigy
       rgb
       ;;terraform
       ;;tmux
       ;;upload
       ;;wakatime

       :os
       arch
       ;;nixos
       tty

       :lang
       ;;(agda +local)
       ;;assembly
       beancount
       (cc +lsp)
       ;;(clojure +lsp)
       ;;(common-lisp +lsp)
       ;;coq
       ;;(crystal +lsp)
       ;;(csharp +lsp +unity)
       ;;data
       ;;(dart +flutter)
       ;;(erlang +lsp)
       ;;(elixir +lsp)
       ;;(elm +lsp)
       emacs-lisp
       (ess +lsp)
       ;;faust
       ;;fstar
       ;;gdscript
       ;;(fsharp +lsp)
       (go +lsp)
       (haskell +dante +lsp +ghcide)
       ;;(hy +lsp)
       ;;(idris +lsp)
       ;;(json +lsp)
       ;;(java +lsp)
       (javascript +lsp)
       (julia +lsp)
       ;;(kotlin +lsp)
       (latex +latexmk +cdlatex +fold +lsp)
       ;;(lean +lsp)
       ;;factor
       ;;(ledger +lsp)
       ;;(lua +monoscript)
       (markdown +grip)
       ;;(nim +lsp)
       ;;(nix +lsp)
       ;;(ocaml +lsp)
       (org
        +brain
        +dragndrop
        +gnuplot
        +hugo
        +ipython
        +journal
        +jupyter
        +noter
        +pandoc
        +present
        +pomodoro
        +pretty
        +roam2)
       ;(perl +lsp)
       ;;(php +lsp)
       plantuml
       ;;(purescript +lsp)
       (python
        +conda
        +lsp
        +pyright
        +cython)
       ;;qt
       ;;racket
       (raku +lsp)
       ;;rest
       rst
       (ruby +lsp) ;+rvm +rbenv +rails +chruby)
       (rust +lsp)
       ;;(scala +lsp)
       scheme
       (sh +lsp +fish)
       ;;sml
       ;;solidity
       ;;(swift +lsp)
       ;;terra
       (web +lsp)
       (yaml +lsp)

       :email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;irc
       (rss +org)
       ;twitter

       :private
       archlinux
       blog
       conda
       cpp
       dap
       doraemon
       dsl
       ereader
       ;;eaf
       ;;email
       git
       jupyter
       lsp
       ;;ohmeta
       org
       python
       r
       rss
       rust
       tex
       tramp
       ui
       gif
       keycast

       :config
       (default +bindings +smartparens))
