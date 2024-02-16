(use-package evil
      :init (setq evil-want-keybinding nil)
    :config
(integrate-evil)
  (start-evil-mode))

(defun integrate-evil ()
    (setq evil-want-integration t))

(defun start-evil-mode ()
(evil-mode))

(use-package evil-collection
    :ensure t
    :after evil
:config (setup-evil-collection))

(defun setup-evil-collection ()
(setq evil-collection-mode-list '(dashboard dired ibuffer))
(evil-collection-init))
