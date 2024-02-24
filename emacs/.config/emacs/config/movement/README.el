(use-package avy)

(with-eval-after-load 'avy
  (with-eval-after-load 'general
    (leader-key
      "l" '(avy-goto-char :wk "Leap"))))

(with-eval-after-load 'general
  (with-eval-after-load 'evil
    (general-define-key
     :states '(normal visual)
     "J" '(lambda () (interactive) (evil-scroll-down nil) (evil-scroll-line-to-center (line-number-at-pos)))
     "K" '(lambda () (interactive) (evil-scroll-up nil) (evil-scroll-line-to-center (line-number-at-pos))))))
