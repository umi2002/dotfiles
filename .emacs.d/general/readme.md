
# Table of Contents

1.  [GENERAL CONFIGURATION](#org8cc4fc1)



<a id="org8cc4fc1"></a>

# GENERAL CONFIGURATION

Functions

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

Setup

    (with-eval-after-load 'general
      (general-evil-setup)
      (setq global-map (make-sparse-keymap))
      (general-define-key
       :states 'normal
       "SPC s" nil)
      )

Defining leader key

    (with-eval-after-load 'general
      (general-create-definer leader
        :states '(normal visual)
        :keymaps '(global override)
        :prefix "SPC"))

Mappings

    (with-eval-after-load 'general
      (general-define-key
       :states '(normal visual)
       :keymaps '(global override)
       "J" 'scroll-up-command
       "K" 'scroll-down-command
       )
    
      (general-define-key
       :states '(normal)
       :keymaps '(global override)
       "C-h" 'evil-window-left
       "C-j" 'evil-window-down 
       "C-k" 'evil-window-up
       "C-l" 'evil-window-right)
    
      (general-create-definer window
        :keymaps '(global override)
        :wrapping leader
        :infix "w")
    
      (window
        "h" 'open-window-left
        "j" 'open-window-down
        "k" 'open-window-up
        "l" 'open-window-right)
    
      (general-define-key
       :states '(normal)
       :keymaps '(global)
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

