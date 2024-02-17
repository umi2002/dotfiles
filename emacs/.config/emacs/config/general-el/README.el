(use-package general)

(with-eval-after-load 'general
(general-evil-setup))

(with-eval-after-load 'general
  (general-create-definer leader-key
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC"))
