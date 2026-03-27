
# Table of Contents

1.  [LSP CONFIG](#org4cf047a)
    1.  [General](#org8952f92)
    2.  [Lua](#org7a24a3e)
    3.  [HTML](#org7da53a1)
    4.  [Typescript](#org220b67e)
    5.  [C](#org17d09d6)
    6.  [C++](#org0032d2e)
    7.  [C#](#orgc2b6cb4)
    8.  [Python](#org6689abc)
2.  [COMPLETION](#orgb28a040)
    1.  [Company-Mode](#org431f91e)
3.  [DIAGNOSTICS](#orgb956cc0)
    1.  [Flycheck](#orgabf7cc2)
    2.  [Helm-Flycheck](#orgc5e0884)
    3.  [Flycheck-Inline](#org8aae52f)
4.  [FORMATTING](#orgca95ced)
    1.  [Format-All-Mode](#org2ceb6fa)



<a id="org4cf047a"></a>

# LSP CONFIG


<a id="org8952f92"></a>

## General

Setup

    (with-eval-after-load 'lsp-mode
      (setq lsp-modeline-code-actions-mode 1))

Lsp-Booster

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

Mappings

    (with-eval-after-load 'helm-xref
      (leader
        "rf" 'xref-find-references
        "df" 'xref-find-definitions))
    
    (with-eval-after-load 'helm-lsp
      (leader
        "ca" 'helm-lsp-code-actions))
    
    (with-eval-after-load 'lsp-ui
      (general-define-key
       :states '(normal visual)
       :keymaps 'lsp-ui-mode-map
       [remap xref-find-definitions] #'lsp-ui-peek-find-definitions
       [remap xref-find-references] #'lsp-ui-peek-find-references))


<a id="org7a24a3e"></a>

## Lua

Lsp-Mode

    (use-package lua-mode
      :after lsp-mode
      :mode "\\.lua\\'"
      :hook (lua-mode . lsp-deferred))
    
    (with-eval-after-load 'lsp-mode
      (add-to-list 'lsp-enabled-clients 'lua-language-server))

Formatting

    (with-eval-after-load 'format-all
      (setq-default format-all-formatters
                    (append format-all-formatters
                            '(("Lua" (stylua))))))


<a id="org7da53a1"></a>

## HTML

Lsp-Mode

    (use-package web-mode
      :after lsp-mode
      :mode ("\\.html\\'")
      :hook (web-mode . lsp-deferred))
    
    (with-eval-after-load 'lsp-mode
      (add-to-list 'lsp-enabled-clients 'html-ls))


<a id="org220b67e"></a>

## Typescript

Lsp-Mode

    (use-package typescript-mode
      :after lsp-mode
      :mode ("\\.ts\\'" "\\.tsx\\'")
      :hook (typescript-mode . lsp-deferred))
    
    (with-eval-after-load 'lsp-mode
      (add-to-list 'lsp-enabled-clients 'ts-ls))

Formatting

    (with-eval-after-load 'format-all
      (setq-default format-all-formatters
                    (append format-all-formatters
                            '(("TypeScript" (prettierd))))))

Linting

    (use-package eslintd-fix
      :after (lsp-mode flycheck)
      :config
      (setq flycheck-javascript-eslint-executable "eslint_d")
      (add-hook 'typescript-mode-hook 'eslintd-fix-mode)
      (setq lsp-eslint-auto-fix-on-save t))


<a id="org17d09d6"></a>

## C

Lsp-Mode

    (with-eval-after-load 'lsp-mode
      (add-hook 'c-mode-hook #'lsp-deferred)
      (add-to-list 'lsp-enabled-clients 'clangd))

Formatting

    (with-eval-after-load 'format-all
      (setq-default format-all-formatters
                    (append format-all-formatters
                            '(("C" (clang-format "--style=Microsoft"))))))


<a id="org0032d2e"></a>

## C++

Lsp-Mode

    (with-eval-after-load 'lsp-mode
      (add-hook 'c++-mode-hook #'lsp-deferred)
      (add-to-list 'lsp-enabled-clients 'clangd))

Formatting

    (with-eval-after-load 'format-all
      (setq-default format-all-formatters
                    (append format-all-formatters
                            '(("C++" (clang-format "--style=Microsoft"))))))


<a id="orgc2b6cb4"></a>

## C#

Lsp-Mode

    (with-eval-after-load 'lsp-mode
      (add-hook 'csharp-mode-hook #'lsp-deferred)
      (add-to-list 'lsp-enabled-clients 'omnisharp))

Formatting

    (with-eval-after-load 'format-all
      (setq-default format-all-formatters
                    (append format-all-formatters
                            '(("C#" (csharpier))))))


<a id="org6689abc"></a>

## Python

Lsp-Mode

    (use-package python-mode
      :after lsp-mode
      :hook (python-mode . lsp-deferred))
    
    (use-package lsp-pyright
      :after lsp-mode
      :custom (lsp-pyright-langserver-command "pyright")
      :config (add-to-list 'lsp-enabled-clients 'pyright))


<a id="orgb28a040"></a>

# COMPLETION


<a id="org431f91e"></a>

## Company-Mode

Setup

    (with-eval-after-load 'company
      (setq company-minimum-prefix-length 1)
      (global-company-mode))

Mappings

    (with-eval-after-load 'company
      (general-define-key
       :keymaps '(company-active-map)
       "<tab>" 'company-complete-selection
       "RET" nil))

Setup

    (with-eval-after-load 'yasnippet
      (yas-global-mode 1))


<a id="orgb956cc0"></a>

# DIAGNOSTICS

Mappings

    (with-eval-after-load 'flycheck
      (general-create-definer diagnostics
        :keymaps '(global override)
        :wrapping leader
        :infix "d")
    
      (diagnostics
        "j" 'flycheck-next-error
        "k" 'flycheck-previous-error))


<a id="orgabf7cc2"></a>

## Flycheck

Setup

    (with-eval-after-load 'flycheck
      (add-hook 'after-init-hook #'global-flycheck-mode))


<a id="orgc5e0884"></a>

## Helm-Flycheck

Mappings

    (with-eval-after-load 'flycheck
      (diagnostics
        "t" 'helm-flycheck))


<a id="org8aae52f"></a>

## Flycheck-Inline

Setup

    (with-eval-after-load 'flycheck
      (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))


<a id="orgca95ced"></a>

# FORMATTING


<a id="org2ceb6fa"></a>

## Format-All-Mode

    (with-eval-after-load 'format-all
      (add-hook 'prog-mode-hook 'format-all-mode))

