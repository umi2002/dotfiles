(defun custom_project_find()
  (interactive)
  (if (projectile-project-p)
      (projectile-find-file)
    (helm-find-files nil)))

(with-eval-after-load 'projectile
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-enable-caching t)
  (setq projectile-git-command "git ls-files -zco --exclude-standard")
  (setq projectile-project-search-path '(("~/code/" . 2) "~/dotfiles/" ("~/code/projects/" . 2)))
  (setq projectile-generic-command "fd . -0 --type f --color=never")
  (setq projectile-completion-system 'helm)
  (setq projectile-cache-file (expand-file-name ".cache/projectile.cache" user-emacs-directory))
  (projectile-mode 1))

(with-eval-after-load 'projectile
  (general-create-definer project
    :keymaps '(global override)
    :wrapping leader
    :infix "p"))

(with-eval-after-load 'projectile
  (leader
    "f" 'custom_project_find)

  (project
    "f" 'projectile-switch-project)

  (leader
    "wf" 'projectile-rg))
