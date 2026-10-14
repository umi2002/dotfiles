(defun load-catppuccin-theme ()
  (load-theme 'catppuccin :noconfirm))

(add-hook 'elpaca-after-init-hook #'load-catppuccin-theme)

(with-eval-after-load 'dimmer
  (dimmer-configure-helm)
  (dimmer-mode t))

(with-eval-after-load 'telephone-line
  (telephone-line-mode 1))

(setq olivetti-body-width 0.8)
(with-eval-after-load 'olivetti
  (add-hook 'text-mode-hook #'olivetti-mode))

(setq mixed-pitch-set-height t)
(with-eval-after-load 'mixed-pitch
  (add-hook 'text-mode-hook #'mixed-pitch-mode))
