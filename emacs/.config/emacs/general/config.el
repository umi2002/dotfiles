(defun open_config ()
  (interactive)
  (find-file "~/.config/emacs/config.org"))

(defun open_window_left()
  (interactive)
  (evil-window-vsplit))

(defun open_window_right()
  (interactive)
  (evil-window-vsplit)
  (evil-window-right 1))

(defun open_window_up()
  (interactive)
  (evil-window-split))

(defun open_window_down()
  (interactive)
  (evil-window-split)
  (evil-window-down 1))

(defun scroll_down_recenter()
  :type 'line
  (interactive)
  (evil-scroll-page-down 1)
  (evil-scroll-line-to-center nil))

(defun scroll_up_recenter()
  :type 'line
  (interactive)
  (evil-scroll-page-up 1)
  (evil-scroll-line-to-center nil))

(with-eval-after-load 'general
  (general-evil-setup)
  (setq global-map (make-sparse-keymap))
  (general-define-key
   :states 'normal
   "SPC s" nil)
  )

(with-eval-after-load 'general
  (general-create-definer leader
    :states 'normal
    :keymaps '(global override)
    :prefix "SPC"))

(with-eval-after-load 'general
  (leader
    "e" 'dired)

  (general-define-key
   :states 'normal
   :keymaps 'dired-mode-map
   "h" 'dired-up-directory
   "l" 'dired-find-file
   "d" 'dired-create-directory
   "n" 'dired-create-empty-file
   "D" 'dired-do-delete)

  (general-create-definer open
    :keymaps '(global override)
    :wrapping leader
    :infix "o")

  (general-define-key
   :states '(normal visual)
   :keymaps '(global override)
   "J" 'scroll_down_recenter
   "K" 'scroll_up_recenter
   )

  (general-define-key
   :states '(normal)
   :keymaps '(global override)
   "C-h" 'evil-window-left
   "C-j" 'evil-window-down 
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right)

  (open
    "c" 'open_config)

  (general-create-definer window
    :keymaps '(global override)
    :wrapping leader
    :infix "w")

  (window
    "h" 'open_window_left
    "j" 'open_window_down
    "k" 'open_window_up
    "l" 'open_window_right)

  (general-define-key
   :states '(normal)
   :keymaps '(global override)
   "RET" 'org-open-at-point)

  (general-create-definer buffer
    :keymaps '(global override)
    :wrapping leader
    :infix "b")

  (buffer
    "n" 'next-buffer
    "p" 'previous-buffer
    "k" 'kill-buffer
    )
  )
