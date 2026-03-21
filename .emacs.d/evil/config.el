(with-eval-after-load 'evil
  (setq evil-want-keybinding nil)
  (evil-mode)
  (evil-set-undo-system 'undo-redo)
  )

(with-eval-after-load 'evil-collection
  (evil-collection-init))
