(with-eval-after-load 'evil-surround
  (global-evil-surround-mode 1))

(with-eval-after-load 'evil-embrace
  (evil-embrace-enable-evil-surround-integration))

(with-eval-after-load 'evil-embrace
  (general-create-definer surround
    :keymaps '(global override)
    :wrapping leader
    :infix "s")

  (surround
    "r" 'evil-embrace-evil-surround-change)
  )

(with-eval-after-load 'evil-commentary
  (evil-commentary-mode))

(with-eval-after-load 'evil-goggles
  (evil-goggles-mode)
  (setq evil-goggles-duration 0.500)
  )
