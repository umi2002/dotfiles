(use-package vterm)

(add-to-list 'display-buffer-alist
             '("\\`\\*vterm\\*\\(?:<[[:digit:]]+>\\)?\\'"
               (display-buffer-in-side-window (side . bottom))))

(defun toggle-vterm ()
  "Toggle a vterm window."
  (interactive)
  (let ((vterm-buffer-name "*vterm*"))
    (if (get-buffer vterm-buffer-name)
        (if (get-buffer-window vterm-buffer-name)
            (delete-window (get-buffer-window vterm-buffer-name))
          (switch-to-buffer-other-window vterm-buffer-name))
      (vterm))))

(with-eval-after-load 'general
  (leader-key
    "`" '(toggle-vterm :wk "Toggle vterm")))
