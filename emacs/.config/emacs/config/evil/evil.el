;; Install use-package support
    (elpaca elpaca-use-package
      ;; Enable use-package :ensure support for Elpaca.
      (elpaca-use-package-mode)
  (setq elpaca-use-package-by-default t))
    ;; Block until current queue processed.
    (elpaca-wait)

    ;;When installing a package which modifies a form used at the top-level
    ;;(e.g. a package which adds a use-package key word),
    ;;use `elpaca-wait' to block until that package has been installed/configured.
    ;;For example:
    ;;(use-package general :ensure t :demand t)
    ;;(elpaca-wait)

    ;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
  (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))

    ;;Turns off elpaca-use-package-mode current declaration
    ;;Note this will cause the declaration to be interpreted immediately (not deferred).
    ;;Useful for configuring built-in emacs features.
    (use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))
