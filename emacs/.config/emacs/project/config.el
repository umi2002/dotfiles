(defun custom_project_find()
  (interactive)
  (if (projectile-project-p)
      (helm-projectile-find-file)
    (helm-find-files nil)))

(with-eval-after-load 'projectile
  (projectile-mode 1))

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
  )
