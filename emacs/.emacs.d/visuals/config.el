(with-eval-after-load 'doom-themes
  (load-theme 'doom-palenight t))

(with-eval-after-load 'dimmer
  (dimmer-configure-helm)
  (dimmer-mode t))

(with-eval-after-load 'telephone-line
  (telephone-line-mode 1))

(with-eval-after-load 'visual-fill-column
  (add-hook 'text-mode-hook
	    (lambda ()
	      (visual-fill-column-mode)
	      (setq fill-column 100)))
  (setq-default visual-fill-column-center-text t))
