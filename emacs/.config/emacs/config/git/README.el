(use-package magit)

(with-eval-after-load 'magit
  (with-eval-after-load 'general
    (leader-key
      "g" '(:ignore t :wk "Git")
      "gs" '(magit-status :wk "Git status")
      "gf" '(magit-pull :wk "Git pull")
      "gp" '(magit-push :wk "Git push")
      "gb" '(magit-branch :wk "Git branch"))))

(use-package git-gutter)

(with-eval-after-load 'git-gutter
  (global-git-gutter-mode +1)
  (setq git-gutter:modified-sign "│")
  (set-face-background 'git-gutter:modified "blue")
  (setq git-gutter:added-sign "│")
  (set-face-background 'git-gutter:added "green")
  (setq git-gutter:deleted-sign "│")
  (set-face-background 'git-gutter:deleted "red")
  (add-hook 'magit-post-refresh-hook
            #'git-gutter:update-all-windows))
