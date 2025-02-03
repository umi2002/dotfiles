(with-eval-after-load 'lsp-mode
  (setq lsp-modeline-code-actions-mode 1))

(with-eval-after-load 'lsp-mode
  (setq lsp-file-watch-ignored-directories
	(append lsp-file-watch-ignored-directories
		projectile-globally-ignored-directories)))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
	 (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
		       (fboundp 'json-parse-buffer))
		'json-parse-buffer
	      'json-read)
	    :around
	    #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
	     (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
	     lsp-use-plists
	     (not (functionp 'json-rpc-connection))  ;; native json-rpc
	     (executable-find "emacs-lsp-booster"))
	(progn
	  (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
	    (setcar orig-result command-from-exec-path))
	  (message "Using emacs-lsp-booster for %s!" orig-result)
	  (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

(with-eval-after-load 'helm-xref
  (leader
    "rf" 'xref-find-references
    "df" 'xref-find-definitions))

(with-eval-after-load 'helm-lsp
  (leader
    "ca" 'helm-lsp-code-actions))

(use-package lua-mode
  :after lsp-mode
  :mode "\\.lua\\'"
  :hook (lua-mode . lsp-deferred))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'lsp-lua))

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("Lua" (stylua))))))

(use-package web-mode
  :after lsp-mode
  :mode ("\\.html\\'")
  :hook (web-mode . lsp-deferred))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'html-ls))

(with-eval-after-load 'lsp-mode
  (setq lsp-clients-angular-language-server-command
	'("node"
	  "/usr/lib/node_modules/@angular/language-server"
	  "--ngProbeLocations"
	  "/usr/lib/node_modules"
	  "--tsProbeLocations"
	  "/usr/lib/node_modules"
	  "--stdio")))

(use-package typescript-mode
  :after lsp-mode
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook (typescript-mode . lsp-deferred))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-enabled-clients 'ts-ls))

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("TypeScript" (prettierd))))))

(use-package eslintd-fix
  :after (lsp-mode typescript-mode)
  :config ((add-hook 'typescript-mode-hook 'eslintd-fix-mode)))

(with-eval-after-load 'lsp-mode
  (add-hook 'c-mode-hook #'lsp-deferred)
  (add-to-list 'lsp-enabled-clients 'lsp-clangd))

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("C" (clang-format "--style=Microsoft"))))))

(with-eval-after-load 'lsp-mode
  (add-hook 'c++-mode-hook #'lsp-deferred)
  (add-to-list 'lsp-enabled-clients 'lsp-clangd))

(with-eval-after-load 'format-all
  (setq-default format-all-formatters
		(append format-all-formatters
			'(("C++" (clang-format "--style=Microsoft"))))))

(with-eval-after-load 'lsp-mode
  (add-hook 'csharp-mode-hook #'lsp-deferred)
  (add-to-list 'lsp-enabled-clients 'omnisharp))

(use-package python-mode
  :after lsp-mode
  :hook (python-mode . lsp-deferred))

(use-package lsp-pyright
  :after lsp-mode
  :custom (lsp-pyright-langserver-command "pyright")
  :config (add-to-list 'lsp-enabled-clients 'pyright))

(with-eval-after-load 'company
  (setq company-minimum-prefix-length 1)
  (global-company-mode))

(with-eval-after-load 'company
  (general-define-key
   :keymaps '(company-active-map)
   "<tab>" 'company-complete-selection
   "RET" nil))

(with-eval-after-load 'yasnippet
  (yas-global-mode 1))

(with-eval-after-load 'flycheck
  (general-create-definer diagnostics
    :keymaps '(global override)
    :wrapping leader
    :infix "d")

  (diagnostics
    "j" 'flycheck-next-error
    "k" 'flycheck-previous-error))

(with-eval-after-load 'flycheck
  (global-flycheck-mode +1))

(with-eval-after-load 'flycheck
  (diagnostics
    "t" 'helm-flycheck))

(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))
