(use-package magit)

(with-eval-after-load 'magit
          (with-eval-after-load 'general
          (leader-key
        "g" '(:ignore t :wk "Git")
      "gs" '(magit-status :wk "Git status")
    "gf" '(magit-pull :wk "Git pull")
  "gp" '(magit-push :wk "Git push")
"gb" '(magit-branch :wk "Git branch"))))
