(defun open-window-left()
  (interactive)
  (evil-window-vsplit))

(defun open-window-right()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun open-window-up()
  (interactive)
  (evil-window-split))

(defun open-window-down()
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

(defun load-config-file()
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(with-eval-after-load 'general
  (general-evil-setup)
  (general-define-key
   :states 'normal
   "SPC s" nil)
  (general-create-definer leader
    :states '(normal visual)
    :keymaps '(global override)
    :prefix "SPC")
  (general-create-definer localleader
    :states '(normal visual)
    :prefix ","))

(with-eval-after-load 'general
  (general-define-key
   "<escape>" 'keyboard-escape-quit)

  (general-create-definer reload
    :wrapping leader
    :infix "r")

  (reload
    "r" 'load-config-file)

  (general-define-key
   :states '(normal visual)
   :keymaps '(global override)
   "J" 'scroll-up-command
   "K" 'scroll-down-command)

  (general-define-key
   :states '(normal)
   :keymaps '(global override)
   "C-h" 'evil-window-left
   "C-j" 'evil-window-down
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right)

  (general-create-definer window
    :wrapping leader
    :infix "w")

  (window
    "h" 'open-window-left
    "j" 'open-window-down
    "k" 'open-window-up
    "l" 'open-window-right)

  (general-define-key
   :states '(normal)
   :keymaps '(org-mode-map)
   "RET" 'org-open-at-point)

  (general-create-definer buffer
    :wrapping leader
    :infix "b")

  (buffer
    "n" 'next-buffer
    "p" 'previous-buffer
    "k" 'kill-buffer)

  (general-define-key
   :states '(normal visual)
   :keymaps '(help-mode-map)
   (kbd "<backtab>") 'outline-cycle-buffer))
