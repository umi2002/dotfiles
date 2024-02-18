(use-package lsp-mode)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1)

(use-package helm-lsp
  :after helm)

(use-package helm-xref
  :after helm)

(use-package flycheck)

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

(with-eval-after-load 'lsp-mode
  (add-hook 'c-mode-hook 'lsp))

(with-eval-after-load 'clang-format
  (add-hook 'c-mode-hook (lambda () (format-on-save 'clang-format-buffer))))

(with-eval-after-load 'lsp-mode
  (add-hook 'c++-mode-hook 'lsp))

(with-eval-after-load 'clang-format
  (add-hook 'c++-mode-hook (lambda () (format-on-save 'my-clang-format-buffer))))
