(use-package general)
(elpaca-wait)

(defun setup-general-evil ()
(general-evil-setup))

(general-create-definer leader-key
:states '(normal insert visual emacs)
:keymaps 'override
:prefix "SPC"
:global-prefix "M-SPC")
