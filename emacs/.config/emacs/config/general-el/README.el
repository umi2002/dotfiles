(use-package general
:ensure t
:demand t)
(elpaca-wait)

(general-evil-setup)

(general-create-definer leader-key
:states '(normal insert visual emacs)
:keymaps 'override
:prefix "SPC"
:global-prefix "M-SPC")
