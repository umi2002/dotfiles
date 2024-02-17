(use-package company)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1)

(use-package yasnippet)
(use-package yasnippet-snippets
:after yasnippet)
