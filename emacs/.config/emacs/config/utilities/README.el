(global-auto-revert-mode t)
(setq-default tab-width 4)

(with-eval-after-load 'general
  (leader-key
    "." '((lambda () (interactive) (load-file user-init-file)) :wk "Reload config")))

(with-eval-after-load 'general
  (leader-key
    "v" '(:ignore t :wk "Evaluate")
    "vb" '(eval-buffer :wk "Evaluate elisp in buffer")
    "vd" '(eval-defun :wk "Evaluate defun containing or after a point")
    "ve" '(eval-expression :wk "Evaluate an elips expression")
    "vr" '(eval-region :wk "Evaluate elisp region")))

(with-eval-after-load 'general
  (leader-key
    "x" '(:ignore t :wk "Export")
    "xm" '(org-md-export-as-markdown :wk "Export as markdown")))

(with-eval-after-load 'general
  (leader-key
    "h" '(:ignore t :wk "Help")
    "hf" '(describe-function :wk "Describe function")
    "hv" '(describe-variable :wk "Describe variable")))
