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

(setq doom-font (font-spec :family "Fira Code" :size 14))

;; TODO: when you use LSP make sure this is nil
;; (setq lsp-signature-auto-activate nil)

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

(use-package! key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define-global "jv" 'avy-goto-char-2)
  (key-chord-define-global "jw" 'ace-window)
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

(use-package! goto-chg
  :config
  (bind-key* "C-c b ," 'goto-last-change)
  (bind-key* "C-c b ." 'goto-last-change-reverse))

(defun ccann/set-mark-no-activate ()
  "Set the mark without activating the region."
  (interactive)
  (push-mark))

(use-package! visible-mark
  :config
  (setq visible-mark-max 1)
  (setq visible-mark-faces '(visible-mark-face1
                             visible-mark-face2
                             visible-mark-face3))
  (global-set-key (kbd "C-x m") 'ccann/set-mark-no-activate)
  (global-visible-mark-mode +1))

(after! lispy
  (setq lispy-compat '(edebug cider)))

(after! cider
  (setq nrepl-hide-special-buffers nil))

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
  :bind (("C-c h s" . symbol-overlay-put)
         ("C-c h r" . symbol-overlay-remove-all))
  :config
  (add-hook! 'prog-mode-hook #'symbol-overlay-mode)
  (add-hook! 'text-mode-hook #'symbol-overlay-mode))

(after! hl-todo
  (add-hook 'text-mode-hook #'hl-todo-mode))

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

;; disable native completion
(after! python
  (setq python-shell-completion-native-enable nil))

(after! lsp-python-ms
  (set-lsp-priority! 'pyright 1))

;;  In case we get a wrong workspace root, we can delete it with lsp-workspace-folders-remove
(after! lsp-mode
  (setq lsp-auto-guess-root nil))

;; increase bytes read from subprocess
(setq read-process-output-max (* 1024 1024))

;; disable LSP-flycheck checker and use flake8
(after! lsp-mode
  (setq lsp-diagnostics-provider :none))

(after! flycheck
    (add-hook 'pyhon-mode-local-vars-hook
            (lambda ()
                (when (flycheck-may-enable-checker 'python-flake8)
                  (flycheck-select-checker 'python-flake8)))))


(after! lsp-mode
  (setq lsp-eldoc-enable-hover nil
        lsp-signature-auto-activate nil
        ;; lsp-enable-on-type-formatting nil
        ;; lsp-enable-symbol-highlighting nil
        lsp-enable-file-watchers nil))


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

;; (good-scroll-mode -1)

;; (setq flycheck-disabled-checkers 'lsp)

;; (after! py-isort
;;   (add-hook 'before-save-hook 'py-isort-before-save))

(advice-add 'risky-local-variable-p :override #'ignore)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((cider-preferred-build-tool . clojure-cli)
     (cider-clojure-cli-global-options . "-A:dev:test:frontend:dev/frontend")
     (auto-fill-mode t)
     (cljr-libspec-whitelist "^thanks.spec" "thanks.oauth.provider.spec" "^integrant.repl$" "^day8.re-frame.http-fx$" "^tick.locale.*$" "^thanks.frontend.*$" "^spell-spec.expound$" "^duct.core.resource*" "^goog.string.format")
     (cider-repl-init-code "(do (dev) (go))")
     (cider-ns-refresh-after-fn . "dev/resume")
     (cider-ns-refresh-before-fn . "dev/suspend")
     (cljr-auto-clean-ns . t)
     (cljr-favor-prefix-notation))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
