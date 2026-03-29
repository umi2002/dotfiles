(with-eval-after-load 'helm
  (general-define-key
   :keymaps 'helm-map
   "C-w" 'backward-kill-word
   "C-j" 'helm-next-line
   "C-k" 'helm-previous-line)

  (buffer
    "f" 'helm-buffers-list)

  (general-define-key
   :states '(normal visual)
   "M-x" 'helm-M-x))

(with-eval-after-load 'avy
  (leader
    "l" 'avy-goto-char-2))
