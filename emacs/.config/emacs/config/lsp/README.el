(use-package lsp-mode)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      lsp-idle-delay 0.1)

(use-package helm-lsp
:after helm)

(use-package helm-xref
:after helm)

(use-package flycheck)

(with-eval-after-load 'lsp-mode
(add-hook 'c++-mode-hook 'lsp))
