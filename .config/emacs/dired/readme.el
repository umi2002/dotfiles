(defun dired-go-home ()
  (interactive)
  (dired "~"))

(with-eval-after-load 'general
  (leader
    "e" 'dired)

  (with-eval-after-load 'dired
    (general-define-key
     :states '(normal)
     :keymaps '(dired-mode-map)
     "h" 'dired-up-directory
     "l" 'dired-find-file
     "d" 'dired-create-directory
     "n" 'dired-create-empty-file
     "D" 'dired-do-delete
     "<escape>" 'revert-buffer
     "gh" 'dired-go-home)))

(with-eval-after-load 'dired-narrow
  (general-define-key
   :states '(normal)
   :keymaps '(dired-mode-map)
   "s" 'dired-narrow))
