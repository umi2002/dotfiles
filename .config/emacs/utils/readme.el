(with-eval-after-load 'evil-surround
  (global-evil-surround-mode 1))

(with-eval-after-load 'evil-embrace
  (evil-embrace-enable-evil-surround-integration))

(with-eval-after-load 'evil-embrace
  (general-create-definer surround
    :wrapping leader
    :infix "s")

  (surround
    "r" 'evil-embrace-evil-surround-change))

(with-eval-after-load 'evil-commentary
  (evil-commentary-mode))

(setq evil-goggles-duration 0.500)
(with-eval-after-load 'evil-goggles
  (evil-goggles-mode))

(setq undo-tree-history-directory-alist `(("." . ,(expand-file-name "undo" user-emacs-directory))))
(with-eval-after-load 'undo-tree
  (global-undo-tree-mode))

(with-eval-after-load 'undo-tree
  (leader
    "u" 'undo-tree-visualize))

(with-eval-after-load 'exec-path-from-shell
  (when (daemonp)
    (exec-path-from-shell-initialize)))

(setq jinx-languages "en_US fr_CA")
(with-eval-after-load 'jinx
  (global-jinx-mode))

(with-eval-after-load 'jinx
  (general-create-definer spell
    :wrapping leader
    :infix "j")

  (spell
    "j" 'jinx-next
    "k" 'jinx-previous
    "c" 'jinx-correct
    "a" 'jinx-correct-all
    "o" 'jinx-occur
    "l" 'jinx-languages))
