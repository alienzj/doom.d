;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom install'
;; will do this for you). The `doom!' block below controls what modules are
;; enabled and in what order they will be loaded. Remember to run 'doom refresh'
;; after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :input
       chinese
       ;;japanese

       :completion
       (company           ; the ultimate code completion backend
        +childframe
       ;;+tng
       )
       ;;helm              ; the *other* search engine for love and life
       ;;ido               ; the other *other* search engine...
       (ivy               ; a search engine for love and life
        +fuzzy
        +icons
        +prescient
        +childframe)

       :ui
       deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       ;;doom-quit         ; DOOM quit-message prompts when you quit Emacs
       ;;fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ;;hydra
       ;;indent-guides     ; highlighted indent columns
       minimap
       (modeline)          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink the current line after jumping
       ;;neotree           ; a project drawer, like NERDTree for vim
       ophints           ; highlight the region an operation acts on
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       ;;pretty-code       ; replace bits of code with pretty symbols
       tabs              ; an tab bar for Emacs
       treemacs          ; a project drawer, like neotree but cooler
       ;;unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       (window-select     ; visually switch windows
        +switch-window
        +numbers)
       workspaces        ; tab emulation, persistence & separate workspaces
       zen

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       format ;;+onsave) ;;+onsave)  ; automated prettiness
       ;;lispy             ; vim for lisp, for people who dont like vim
       multiple-cursors  ; editing in many places at once
       ;;objed             ; text object editing for the innocent
       ;;parinfer          ; turn lisp into python, sort of
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       ;;word-wrap         ; soft wrapping with language-aware indent

       :checkers
       (syntax
        +childframe)
       ;(spell +everywhere +aspell +hunspell)
       ;grammar

       :emacs
       (dired             ; making dired pretty [functional]
        +ranger
        +icons)
       electric          ; smarter, keyword-based electric-indent
       vc                ; version-control and Emacs, sitting in a tree
       (ibuffer
        +icons)
       (undo
        +tree)

       :term
       eshell            ; a consistent, cross-platform shell (WIP)
       shell             ; a terminal REPL for Emacs
       term              ; terminals in Emacs
       vterm             ; another terminals in Emacs

       :tools
       ansible
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       direnv
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)              ; run code, run (also, repls)
       gist              ; interacting with github gists
       (lookup           ; helps you navigate your code and documentation
        +dictionary
        +offline
        +docsets)        ; ...or in Dash docsets locally
       (lsp +peek)
       ;;macos             ; MacOS-specific commands
       (magit             ; a git porcelain for Emacs
        +forge)
       make              ; run make tasks from Emacs
       (pass +auth)             ; password manager for nerds
       pdf               ; pdf enhancements
       ;;prodigy           ; FIXME managing external services & code builders
       rgb               ; creating color strings
       ;;terraform         ; infrastructure as code
       tmux              ; an API for interacting with tmux
       upload            ; map local to remote projects via ssh/ftp
       ;;wakatime

       :lang
       (agda +local)       ; types of types of types of types...
       (cc +lsp)                ; C/C++/Obj-C madness
       ;;(clojure +lsp)           ; java with a lisp
       (common-lisp +lsp)      ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;(crystal +lsp)          ; ruby at the speed of c
       ;;(csharp +lsp +unity)           ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       ;;(dart +flutter)
       ;;(erlang +lsp)           ; an elegant language for a more civilized age
       ;;(elixir +lsp)          ; erlang done right
       ;;(elm +lsp)              ; care for a cup of TEA?
       emacs-lisp       ; drown in parentheses
       (ess +lsp)               ; emacs speaks statistics
       ;;faust
       ;;fstar
       ;;gdscript
       ;;(fsharp +lsp)          ; ML stands for Microsoft's Language
       (go +lsp)               ; the hipster dialect
       (haskell +dante +lsp +ghcide) ; a language that's lazier than I am
       ;;(hy +lsp)               ; readability of scheme w/ speed of python
       ;;(idris +lsp)             ;
       (json +lsp)
       (java +lsp) ; the poster child for carpal tunnel syndrome
       (javascript +lsp)     ; all(hope(abandon(ye(who(enter(here))))))
       ;;(julia +lsp)            ; a better, faster MATLAB
       (kotlin +lsp)           ; a better, slicker Java(Script)
       (latex +latexmk             ; writing papers in Emacs has never been so fun
              +cdlatex
              +fold
              +lsp)
       ;;(lean +lsp)
       ;;factor
       ;;(ledger +lsp)           ; an accounting system in Emacs
       ;;(lua +monoscript)              ; one-based indices? one-based indices
       (markdown +grip)         ; writing docs for people to ignore
       (nim +lsp)               ; python + lisp at the speed of c
       (nix +lsp)              ; I hereby declare "nix geht mehr!"
       (ocaml +lsp)            ; an objective camel
       (org              ; organize your plain life in plain text
        +brain
        +dragndrop       ; drag & drop files/images into org buffers
        +gnuplot
        +hugo
        +ipython
        +journal        ; using org-mode for presentations
        +jupyter         ; ipython/jupyter support for babel
        +noter
        +pandoc          ; export-with-pandoc support
        +present
        +pandoc
        +pomodoro
        +present
        +roam)        ; using org-mode for presentations
       (raku +lsp)            ; write code no one else can comprehend
       (php +lsp)               ; perl's insecure younger brother
       plantuml          ; diagrams for confusing people more
       (purescript +lsp)       ; javascript, but functional
       (python
        +pyenv
        +conda
        +lsp
        +cython
        +poetry)           ; beautiful is better than ugly
       qt               ; the 'cutest' gui framework ever
       racket            ; a DSL for DSLs
       raku
       rest            ; Emacs as a REST client
       rst
       (ruby +lsp +rvm +rbenv +rails +chruby)   ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       (rust +lsp)             ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (scala +lsp)           ; java, but good
       scheme           ; a fully conniving family of lisps
       (sh +lsp +fish)               ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity          ; do you need a blockchain? No.
       (swift +lsp)            ; who asked for emoji variables?
       ;;terra             ; Earth and Moon in alignment for performance.
       (web +lsp)              ; the tubes
       (yaml +lsp)

       :email
       (mu4e +gmail)       ; WIP
       ;;notmuch             ; WIP
       ;;(wanderlust +gmail) ; WIP

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       calendar
       irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       twitter           ; twitter client https://twitter.com/vnought

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
       ;; config. Use it as a reference for your own modules.
       (default +bindings +smartparens))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/documents/doraemon/org/idea.org"
     "~/documents/doraemon/org/workflow.org")))

 ;;'(conda-anaconda-home "~/.conda/envs/bioenv")
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
