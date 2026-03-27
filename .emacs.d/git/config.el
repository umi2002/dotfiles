(defun git-gutter-yadm-setup ()
  (when (and (not (locate-dominating-file default-directory ".git"))
             (string-prefix-p (expand-file-name "~") (expand-file-name default-directory))
             (file-directory-p "~/.local/share/yadm/repo.git"))
    (setq-local git-gutter:git-args
                '("--work-tree=/home/umi"
                  "--git-dir=/home/umi/.local/share/yadm/repo.git"))))

(with-eval-after-load 'git-gutter
  (global-git-gutter-mode +1)
  (add-hook 'find-file-hook #'git-gutter-yadm-setup))
