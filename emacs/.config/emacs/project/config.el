(defun custom_project_find()
  (interactive)
  (if (projectile-project-p)
      (helm-projectile-find-file)
    (helm-find-files nil)))

(with-eval-after-load 'projectile
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-enable-caching t)
  (setq projectile-git-command "git ls-files -zco --exclude-standard")
  (setq projectile-project-search-path '("~/code/" "~/dotfiles/"))
  (setq projectile-generic-command "fd . -0 --type f --color=never")
  (projectile-mode 1)
  )

(with-eval-after-load 'projectile
  (general-create-definer project
    :keymaps '(global override)
    :wrapping leader
    :infix "p")
  )

(with-eval-after-load 'helm-projectile
  (helm-projectile-on))

(with-eval-after-load 'helm-projectile
  (leader
    "f" 'custom_project_find)

  (project
    "f" 'helm-projectile-switch-project)

  (leader
    "wf" 'helm-projectile-rg)
  )
