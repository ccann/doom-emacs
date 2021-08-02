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

;; (use-package! god-mode
;;   :init
;;   (defun god-mode-update-cursor ()
;;     (setq cursor-type
;;           (if (or god-local-mode buffer-read-only)
;;               'box
;;             'bar)))
;;   (add-hook 'god-mode-enabled-hook 'god-mode-update-cursor)
;;   (add-hook 'god-mode-disabled-hook 'god-mode-update-cursor)
;;   :config
;;   ;; (setq god-exempt-major-modes nil
;;   ;;       god-exempt-predicates nil)
;;   (god-mode-all))
;;
(after! god-mode
  (add-to-list 'god-exempt-major-modes 'browse-kill-ring-mode)
  (add-to-list 'god-exempt-major-modes 'cider-test-report-mode))

;; ;; god-mode helpers
;; (bind-key* "C-x C-1 " 'delete-other-windows)
;; (bind-key* "C-x C-2" 'split-window-below)
;; (bind-key* "C-x C-3" 'split-window-right)
;; (bind-key* "<f10>" 'magit-status)
;; (bind-key* "C-x C-0" 'delete-window)



(use-package! key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define-global "fd" 'god-local-mode)
  (key-chord-define-global "jc" 'save-buffer)
  (key-chord-define-global "fb" '+ivy/switch-buffer)
  (key-chord-define-global "jf" 'counsel-projectile)
  (key-chord-define-global "jp" 'projectile-switch-project)
  (key-chord-define-global "cv" 'recenter))

(bind-key* "C-x b" 'ivy-switch-buffer)
(bind-key* "C-s" 'counsel-grep-or-swiper)

(after! ivy
  (setq swiper-use-visual-line-p #'ignore))

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

(bind-key* "C-o" 'other-window)

;; (use-package! goto-chg
;;   :config
;;   (bind-key* "C-c b ," 'goto-last-change)
;;   (bind-key* "C-c b ." 'goto-last-change-reverse))

;; (defun ccann/set-mark-no-activate ()
;;   "Set the mark without activating the region."
;;   (interactive)
;;   (push-mark))

;; (use-package! visible-mark
;;   :config
;;   (setq visible-mark-max 1)
;;   (setq visible-mark-faces '(visible-mark-face1
;;                              visible-mark-face2
;;                              visible-mark-face3))
;;   (global-set-key (kbd "C-x m") 'ccann/set-mark-no-activate)
;;   (global-visible-mark-mode +1))

(after! lispy
  (setq lispy-compat '(edebug cider)))

(after! cider
  (setq nrepl-hide-special-buffers nil)
  (setq cider-default-cljs-repl 'figwheel-main)
  (setq cider-repl-pop-to-buffer-on-connect nil))

(after! clojure-mode
  (setq tab-always-indent 'complete)
  (remove-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (setq lsp-lens-enable t))

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

(defvar curr-theme nil)

(defvar my-themes
  '(
    ;; dark themes
    doom-opera
    doom-one
    doom-nord
    doom-wilmersdorf
    doom-spacegrey
    doom-city-lights
    doom-solarized-dark
    doom-sourcerer
    kaolin-temple
    kaolin-dark
    ;; kaolin-aurora
    kaolin-eclipse
    ;; kaolin-ocean
    ;; kaolin-galaxy
    kaolin-valley-dark
    kaolin-blossom

    ;; Light Themes
    flatui
    doom-nord-light
    kaolin-light
    kaolin-valley-light
    kaolin-breeze))

(setq enable-local-variables t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme (car my-themes))

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
  :hook ((prog-mode . symbol-overlay-mode)
         (css-mode . symbol-overlay-mode)
         (yaml-mode . symbol-overlay-mode)
         (conf-mode . symbol-overlay-mode)
         (markdown-mode . symbol-overlay-mode)
         (help-mode . symbol-overlay-mode))
  :bind (("C-c h s" . symbol-overlay-put)
         ("C-c h r" . symbol-overlay-remove-all)))

(after! hl-todo
  (add-hook 'text-fmode-hook #'hl-todo-mode))

(after! direnv
  (setq direnv-show-paths-in-summary nil
        direnv-always-show-summary nil))

(use-package! highlight-indent-guides
  :init
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?|
        ;; highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-dots
        highlight-indent-guides-responsive 'top)
  :config
  (add-hook! 'yaml-mode-hook #'highlight-indent-guides-mode))

(after! poetry
  (setq poetry-tracking-mode 't))

(after! sql-mode
  (sql-set-product 'postgres))

(defadvice! +ipython-use-virtualenv (orig-fn &rest args)
  "Use the Python binary from the current virtual environment."
  :around #'+python/open-repl
  (if (getenv "VIRTUAL_ENV")
      (let ((python-shell-interpreter (executable-find "ipython")))
        (apply orig-fn args))
    (apply orig-fn args)))

;; silence warnings when opening REPL
(setq python-shell-prompt-detect-failure-warning nil)

;; python console to the bottom
(set-popup-rule! "^\\*Python*"  :side 'bottom :size .30)

(after! python
  (setq tab-always-indent 'complete)
  ;; disable native completion
  (setq python-shell-completion-native-enable nil))

(after! lsp-python-ms
  (set-lsp-priority! 'pyright 1))

;; increase bytes read from subprocess
(setq read-process-output-max (* 1024 1024))

(after! flycheck
    (add-hook 'pyhon-mode-local-vars-hook
            (lambda ()
                (when (flycheck-may-enable-checker 'python-flake8)
                  (flycheck-select-checker 'python-flake8)))))

(after! lsp-mode
  (setq
   ;;  In case we get a wrong workspace root, we can delete it with lsp-workspace-folders-remove
   ;; lsp-auto-guess-root nil
   lsp-eldoc-enable-hover nil
   ;; lsp-signature-auto-activate nil
   ;; disable LSP-flycheck checker and use flake8
   ;; lsp-diagnostics-provider :none
   ;; lsp-enable-on-type-formatting nil
   ;; lsp-enable-symbol-highlighting nil
   ;; lsp-enable-file-watchers nil
   (setq lsp-clojure-custom-server-command '("bash" "-c" "/usr/local/bin/clojure-lsp"))
   ))

(after! python-pytest
  (setq python-pytest-arguments '("--color" "--failed-first"))
  (evil-set-initial-state 'python-pytest-mode 'normal))

(setq py-isort-options
      '("--thirdparty=gevent"
        "--thirdparty=psycopg2"
        "--thirdparty=datadog"
        "--thirdparty=ujson"
        "--thirdparty=boto"
        "--thirdparty=boto3"
        "--thirdparty=botocore"
        "--thirdparty=jose"
        "--thirdparty=werkzeug"
        "--thirdparty=aiosql"
        "--thirdparty=bottle"
        "--thirdparty=six"
        "--thirdparty=humps"
        "--thirdparty=Crypto"
        "--thirdparty=pybase"
        "--thirdparty=bson"
        "--thirdparty=ffprobe"
        "--section-default=LOCALFOLDER"))

(set-popup-rule! "^\\*pytest*" :side 'right :size .50)

;; try to eliminate flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(advice-add 'risky-local-variable-p :override #'ignore)

(after! lsp-pyright
  (setq lsp-pyright-auto-import-completions nil
        lsp-pyright-typechecking-mode "off"))

(setq git-commit-summary-max-length 100)

(setq fill-column 89)

(auto-fill-mode 1)

(bind-key* "C-M-." 'mark-sexp)
