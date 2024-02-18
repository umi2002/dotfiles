(use-package evil
  :init (setq evil-want-keybinding nil))

(with-eval-after-load 'evil
  (setq evil-want-integration t)
  (evil-ex-define-cmd "e[macs]" 'execute-extended-command))

(with-eval-after-load 'evil
  (evil-mode))

(use-package evil-collection
  :after evil)

(with-eval-after-load 'evil-collection
  (setq evil-collection-mode-list '(dashboard dired ibuffer magit))
  (evil-collection-init))
