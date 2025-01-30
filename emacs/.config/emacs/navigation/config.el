(with-eval-after-load 'helm
  (general-define-key
   :keymaps 'helm-map
   "C-w" 'backward-kill-word
   "C-j" 'helm-next-line
   "C-k" 'helm-previous-line)

  (buffer
    "f" 'helm-buffers-list)
  )
