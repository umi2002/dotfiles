(setq use-package-always-ensure t)
(setq native-comp-async-report-warnings-errors nil)
(add-hook 'prog-mode-hook (lambda ()
			    (setq display-line-numbers-type 'relative)
			    (display-line-numbers-mode 1)))
(scroll-bar-mode -1)
(electric-pair-mode 1)
(tool-bar-mode -1)
(global-hl-line-mode 1)
(custom-set-faces '(org-default ((t
				  (:family "FiraMono Nerd"
					   :height 100)))))
