(defun dired-go-home ()
  (interactive)
  (dired "~"))

(with-eval-after-load 'general
  (leader
    "e" 'dired))

(with-eval-after-load 'evil
  (evil-define-key 'normal dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file
    "d" 'dired-create-directory
    "n" 'dired-create-empty-file
    "D" 'dired-do-delete
    (kbd "<escape>") 'revert-buffer
    "gh" 'dired-go-home)
  )

(with-eval-after-load 'evil
  (with-eval-after-load 'dired-narrow
    (evil-define-key 'normal dired-mode-map
      "s" 'dired-narrow)
    ))
