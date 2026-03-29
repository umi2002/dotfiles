(defun helm-project-files ()
  (interactive)
  (let ((project (project-current t)))
    (helm :sources
          (helm-build-sync-source "Project Files"
            :candidates (project-files project)
	    :fuzzy-match t
            :action #'find-file)
          :buffer "*helm project files*")))

(defun custom-project-find()
  (interactive)
  (if (project-current nil)
      (helm-project-files)
    (helm-find-files nil)))

(defun project-try-yadm (dir)
  (when (and (string-prefix-p (expand-file-name "~") (expand-file-name dir))
             (file-directory-p "~/.local/share/yadm/repo.git")
             (not (locate-dominating-file dir ".git")))
    (cons 'yadm "~/")))

(defun helm-project-switch ()
  (interactive)
  (helm :sources
	(helm-build-sync-source "Projects"
	  :candidates (project-known-project-roots)
	  :fuzzy-match t
	  :action #'project-switch-project)
	:buffer "*helm project switch*"))

(cl-defmethod project-root ((project (head yadm)))
  (cdr project))
(add-hook 'project-find-functions #'project-try-vc)
(add-hook 'project-find-functions #'project-try-yadm)
(cl-defmethod project-files ((project (head yadm)) &optional _dirs)
  (let ((default-directory (project-root project)))
    (mapcar (lambda (f) (expand-file-name f (project-root project)))
            (split-string (shell-command-to-string "yadm ls-files") "\n" t))))
(setq project-switch-commands 'project-dired)

(with-eval-after-load 'general
  (general-create-definer project
    :keymaps '(global override)
    :wrapping leader
    :infix "p")

  (leader
    "f" 'custom-project-find)

  (project
    "f" 'helm-project-switch)

  (leader
    "wf" 'project-find-regexp))
