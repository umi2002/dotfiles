(with-eval-after-load 'dimmer
  (dimmer-configure-helm)
  (dimmer-mode t))

(with-eval-after-load 'telephone-line
  (telephone-line-mode 1))

(setq olivetti-body-width 200)
(with-eval-after-load 'olivetti
  (add-hook 'text-mode-hook #'olivetti-mode)
  (add-hook 'org-mode-hook #'olivetti-mode)
  (olivetti-mode 1))

(with-eval-after-load 'mixed-pitch
  (add-hook 'text-mode-hook #'mixed-pitch-mode))
