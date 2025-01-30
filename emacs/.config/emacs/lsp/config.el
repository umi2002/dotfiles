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

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("Lua" (stylua))))))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :ensure t
  :hook (typescript-mode . lsp-deferred))

(add-hook 'c-mode-hook 'lsp)

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("C" (clang-format "--style=Microsoft"))))))

(add-hook 'c++-mode-hook 'lsp)

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("C++" (clang-format "--style=Microsoft"))))))

(with-eval-after-load 'company
  (setq company-minimum-prefix-length 1)
  (global-company-mode)
  )

(with-eval-after-load 'company
  (general-define-key
   :keymaps '(company-active-map)
   "<tab>" 'company-complete-selection))

(with-eval-after-load 'yasnippet
  (yas-global-mode 1))

(with-eval-after-load 'flycheck
  (global-flycheck-mode +1)
  )

(with-eval-after-load 'flycheck
  (general-create-definer diagnostics
    :keymaps '(global override)
    :wrapping leader
    :infix "d")

  (diagnostics
    "f" 'helm-flycheck)
  )

(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
