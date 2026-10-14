(with-eval-after-load 'evil
  (evil-mode)
  (evil-set-undo-system 'undo-tree))

(with-eval-after-load 'evil-collection
  (evil-collection-init))
