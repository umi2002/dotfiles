(use-package evil
:init (setq evil-want-keybinding nil))

(with-eval-after-load 'evil
(setq evil-want-integration t))

(with-eval-after-load 'evil
(evil-mode))

(use-package evil-collection
:after evil)

(with-eval-after-load 'evil-collection
(setq evil-collection-mode-list '(dashboard dired ibuffer))
(evil-collection-init))
