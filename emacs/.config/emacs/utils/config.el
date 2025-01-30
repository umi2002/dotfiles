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

(defun toggle_vterm ()
  "Toggle between vterm and current buffer."
  (interactive)
  (if (string= major-mode "vterm-mode")
      (evil-switch-to-windows-last-buffer)
    (if (get-buffer "vterm")
	(switch-to-buffer "vterm")
      (vterm))))

(with-eval-after-load 'vterm
  (leader
    "`" 'toggle_vterm)
  )
