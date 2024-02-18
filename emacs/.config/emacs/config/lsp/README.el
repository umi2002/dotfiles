(use-package lsp-mode)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1)

(use-package helm-lsp
  :after helm)

(use-package helm-xref
  :after helm)

(use-package flycheck)

(with-eval-after-load 'flycheck
(global-flycheck-mode))

(use-package clang-format)

(defun format-on-save (format-function)
  (make-local-variable 'before-save-hook)
  (add-hook 'before-save-hook
            format-function nil t))

(with-eval-after-load 'clang-format
  (defun my-clang-format-buffer ()
    (interactive)
    (let ((has-dot-clang-format (locate-dominating-file "." ".clang-format")))
      (if has-dot-clang-format
          (clang-format-buffer)
        (clang-format-buffer-clangify "Google"))))

  (defun clang-format-buffer-clangify (style)
    (let ((clang-format-style style))
      (clang-format-buffer))))

(use-package tide)

(with-eval-after-load 'lsp-mode
  (add-hook 'c-mode-hook 'lsp))

(with-eval-after-load 'clang-format
  (add-hook 'c-mode-hook (lambda () (format-on-save 'clang-format-buffer))))

(with-eval-after-load 'lsp-mode
  (add-hook 'c++-mode-hook 'lsp))

(with-eval-after-load 'clang-format
  (add-hook 'c++-mode-hook (lambda () (format-on-save 'my-clang-format-buffer))))

(use-package typescript-mode)

(with-eval-after-load 'tide
  (add-hook 'typescript-mode-hook (lambda () (tide-setup)
                                    (tide-hl-identifier-mode +1))))

(use-package web-mode)

(with-eval-after-load 'web-mode
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist '(("angular" . "\\.component.html\\'")))
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))
