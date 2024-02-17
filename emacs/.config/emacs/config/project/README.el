(use-package projectile)

(with-eval-after-load 'helm-projectile
  (with-eval-after-load 'general
  (leader-key
"pf" '(helm-projectile-switch-project :wk "Project find"))))

(with-eval-after-load 'projectile
(projectile-mode +1)
(setq projectile-project-search-path '(("~/code/") "~/dotfiles/")))

(with-eval-after-load 'projectile
(setq projectile-project-root-functions
  '(projectile-root-local
    projectile-root-marked
    projectile-root-bottom-up
    projectile-root-top-down
    projectile-root-top-down-recurring)))
