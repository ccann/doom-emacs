;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Cody Canning"
      user-mail-address "cocanning11@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.

(setq doom-font (font-spec :family "Fira Code" :size 12 :slant 'normal :weight 'normal))

;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'kaolin-temple)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! lsp-mode
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil))

(use-package! key-chord
  :config
  (key-chord-mode 1)
  ;; (key-chord-define-global "jv" 'avy-goto-char-2)
  ;; (key-chord-define-global "jw" 'ace-window)
  (key-chord-define-global "jc" 'save-buffer)
  (key-chord-define-global "fb" '+ivy/switch-buffer)
  (key-chord-define-global "jf" 'counsel-projectile)
  (key-chord-define-global "jp" 'projectile-switch-project)
  (key-chord-define-global "cv" 'recenter))

;; (bind-key* "C-x b" 'ivy-switch-buffer)
;; (bind-key* "C-s" 'counsel-grep-or-swiper)

(use-package! ivy-posframe
  :config
  (setq ivy-posframe-display-functions-alist
        ;; use minibuffer default for swiper because frame will occlude buffer
        '((swiper          . ivy-display-function-fallback)
          (complete-symbol . ivy-posframe-display-at-point)
          (t               . ivy-posframe-display-at-frame-center)))
  (setq ivy-posframe-parameters
        '((left-fringe . 10)
          (right-fringe . 5)))
  (ivy-posframe-mode 1))

(setq warning-minimum-level :emergency)

(setq-default cursor-type 'bar)

;; (bind-key* "C-o" 'other-window)

(after! lispy
  (setq lispy-compat '(edebug cider)))

(after! cider
  (setq nrepl-hide-special-buffers nil)
  (setq cider-default-cljs-repl 'figwheel-main)
  (setq cider-repl-pop-to-buffer-on-connect nil))

(after! clojure-mode
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode))

(after! clj-refactor
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (setq cljr-magic-require-namespaces
        '(("io" . "clojure.java.io")
          ("set" . "clojure.set")
          ("str" . "clojure.string")
          ("walk" . "clojure.walk")
          ("zip" . "clojure.zip")
          ("s" . "clojure.spec")
          ("log" . "taoensso.timbre")
          ("casex" . "camel-snake-kebab.extras")
          ("case" . "camel-snake-kebab.core")
          ("mount" . "mount.core")
          ("dfs" . "net.danielcompton.defn-spec-alpha")
          ("ig" . "integrant.core"))))

;; (use-package! visual-regexp
;;   :config
;;   (bind-key* "C-c r r" 'vr/replace)
;;   (bind-key* "C-c r q" 'vr/query-replace))

;; (use-package! visual-regexp-steroids
;;   :after (visual-regexp))
;; (use-package! nano-theme)

(defvar curr-theme nil)
(defvar my-themes
  '(
    ;; dark themes
    nano
    doom-wilmersdorf
    doom-spacegrey
    doom-laserwave
    doom-city-lights
    kaolin-temple
    kaolin-dark
    kaolin-aurora
    kaolin-eclipse
    kaolin-ocean
    kaolin-galaxy
    kaolin-valley-dark
    doom-one

    ;; Light Themes
    flatui
    kaolin-light
    kaolin-valley-light
    kaolin-breeze))

(defun ccann/cycle-theme ()
  "Cycle through a list of themes, my-themes."
  (interactive)
  (when curr-theme
    (disable-theme curr-theme)
    (setq my-themes (append my-themes (list curr-theme))))
  (setq curr-theme (pop my-themes))
  (load-theme curr-theme t)
  (message (symbol-name curr-theme))
  ;; (set-face-attribute 'mode-line nil :box nil)
  ;; (set-face-attribute 'mode-line-inactive nil :box nil)
  )

(bind-key* "<f10>" 'ccann/cycle-theme)

(use-package! symbol-overlay
  :bind (("C-c h s" . symbol-overlay-put)
         ("C-c h r" . symbol-overlay-remove-all))
  :config
  (add-hook 'prog-mode-hook #'symbol-overlay-mode))

(after! direnv
  (setq direnv-show-paths-in-summary nil
        direnv-always-show-summary nil))


(after! lsp-pyright
  (setq lsp-pyright-auto-import-completions nil
        lsp-pyright-typechecking-mode "off"))

(after! electric
  (setq tab-always-indent 'complete))

(after! magit
  (setq git-commit-summary-max-length 100))

(setq fill-column 89)

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode             ; elisp's mechanisms are good enough
            sql-mode                    ; sqlformat is currently broken
            tex-mode                    ; latexindent is broken
            latex-mode
            python-mode
            clojure-mode
            clojurescript-mode))

(auto-fill-mode 1)
