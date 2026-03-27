(with-eval-after-load 'evil
  (evil-mode)
  (evil-set-undo-system 'undo-redo)
  )

(with-eval-after-load 'evil-collection
  (evil-collection-init))
