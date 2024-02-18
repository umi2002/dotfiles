(use-package company)

(with-eval-after-load 'company
(add-hook 'after-init-hook 'global-company-mode)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1))

(with-eval-after-load 'company
  (general-define-key
   :keymaps 'company-active-map
   "C-j" 'company-select-next
   "C-k" 'company-select-previous
   "<tab>" 'company-complete
   "<ESC>" 'company-abort))

(use-package yasnippet)
(use-package yasnippet-snippets
:after yasnippet)

(with-eval-after-load 'lsp-mode
  (yas-global-mode))
