(with-eval-after-load 'general
  (general-create-definer comment-leader-normal
  :states '(normal)
  :keymaps 'override
  :prefix "gc")

  (general-create-definer comment-leader-visual
  :states '(visual)
  :keymaps 'override
  :prefix "gc"))

(with-eval-after-load 'general
  (comment-leader-normal
 "" '(:ignore t :wk "Comment")
"c" '(comment-line :wk "Comment line")))
