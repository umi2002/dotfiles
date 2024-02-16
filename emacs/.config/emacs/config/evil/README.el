(use-package evil
:ensure t
:demand t
:init
    (setq evil-want-keybinding nil))
(elpaca-wait)

(evil-mode)

(use-package evil-collection
:after evil
:ensure t
:demand t)
(elpaca-wait)

(setq evil-collection-mode-list '(dashboard dired ibuffer))
(evil-collection-init)
