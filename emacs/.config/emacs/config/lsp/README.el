(use-package lsp-mode)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1)

(use-package helm-lsp
:after helm)

(use-package helm-xref
:after helm)

(use-package flycheck)

(defun format-on-save (format-function)
(add-hook 'before-save-hook
(lambda ()
(funcall format-function))) nil t)

(use-package clang-format)

  (with-eval-after-load 'clang-format
  (setq clang-format-fallback-style "Google")
(add-hook 'c-mode-hook (lambda () (format-on-save 'clang-format-buffer))))

(with-eval-after-load 'lsp-mode
(add-hook 'c++-mode-hook 'lsp))
