(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook
		      (lambda ()
			(indent-region (point-min) (point-max)))
		      nil 'local)))

(use-package lua-mode
  :mode "\\.lua\\'"
  :ensure t
  :hook (lua-mode . lsp-deferred))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :ensure t
  :hook (typescript-mode . lsp-deferred))
