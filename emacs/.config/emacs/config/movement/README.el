(use-package avy)

(with-eval-after-load 'avy
    (with-eval-after-load 'general
  (leader-key
"l" '(avy-goto-char :wk "Leap"))))
