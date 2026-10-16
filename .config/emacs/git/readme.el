(with-eval-after-load 'general
  (leader
    "g" 'magit-status))

(with-eval-after-load 'git-gutter
  (global-git-gutter-mode +1))
