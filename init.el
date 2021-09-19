;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a "Module Index" link where you'll find
;;      a comprehensive list of Doom's modules and what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :completion
       company                          ; the ultimate code completion backend
       (ivy +icons +childframe +prescient) ; a search engine for love and life

       :ui
       doom                      ; what makes DOOM look the way it does
       doom-dashboard            ; a nifty splash screen for Emacs
       doom-quit                 ; DOOM quit-message prompts when you quit Emacs
       emoji
       hl-todo                ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline               ; snazzy, Atom-inspired modeline, plus API
       ophints                ; highlight the region an operation acts on
       (popup +defaults)      ; tame sudden yet inevitable temporary windows
       (treemacs +lsp)               ; a project drawer, like neotree but cooler
       vc-gutter              ; vcs diff in the fringe
       window-select          ; visually switch windows
       workspaces             ; tab emulation, persistence & separate workspaces

       :editor
       god
       file-templates              ; auto-snippets for empty files
       format                      ; automated prettiness
       ;; lispy                       ; vim for lisp, for people who don't like vim
       word-wrap                   ; soft wrapping with language-aware indent

       :emacs
       (dired +icons)    ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)  ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :checkers
       (syntax +childframe)          ; tasing you for every semicolon you forget

       :tools
       direnv
       editorconfig                ; let someone else argue about tabs vs spaces
       (eval +overlay)             ; run code, run (also, repls)
       lookup                      ; navigate your code and its documentation
       (lsp +peek)
       magit                            ; a git porcelain for Emacs
       make                             ; run make tasks from Emacs
       rgb                              ; creating color strings
       terraform                        ; infrastructure as code

       :lang
       (clojure +lsp)                   ; java with a lisp
       data                      ; config/data formats
       emacs-lisp                ; drown in parentheses
       json                      ; At least it ain't XML
       javascript                ; all(hope(abandon(ye(who(enter(here))))))
       latex                     ; writing papers in Emacs has never been so fun
       markdown                  ; writing docs for people to ignore
       (python +pyenv +lsp +pyright) ; beautiful is better than ugly
       sh                            ; she sells {ba,z,fi}sh shells on the C xor
       web                           ; the tubes
       yaml                          ; JSON, but readable

       :os
       macos

       :config
       (default +bindings +smartparens))
