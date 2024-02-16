(org-babel-load-file
 (expand-file-name
"config/elpaca/elpaca.org"
  user-emacs-directory))

(org-babel-load-file
 (expand-file-name
"config/evil/evil.org"
  user-emacs-directory))

(use-package general
    :config
    (general-evil-setup)

    (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (general-create-definer comment-leader-normal
  :states '(normal)
  :keymaps 'override
  :prefix "gc")

  (general-create-definer comment-leader-visual
  :states '(visual)
  :keymaps 'override
  :prefix "gc")

(leader-keys
"." '((lambda () (interactive) (load-file user-init-file)) :wk "Reload config"))

  (leader-keys
  "f" '(find-file :wk "Find file")
  "c f" '((lambda () (interactive) (find-file "~/.config/emacs/config/config.org")) :wk "Edit emacs config"))

  (leader-keys
    "b" '(:ignore t :wk "buffer")
    "bf" '(ibuffer :wk "Ibuffer")
    "bb" '(switch-to-buffer :wk "Switch buffer")
    "bk" '(kill-this-buffer :wk "Kill this buffer")
    "bn" '(next-buffer :wk "Next buffer")
    "bp" '(previous-buffer :wk "Previous buffer")
    "br" '(revert-buffer :wk "Reload buffer"))

  (leader-keys
  "v" '(:ignore t :wk "Evaluate")
  "vb" '(eval-buffer :wk "Evaluate elisp in buffer")
  "vd" '(eval-defun :wk "Evaluate defun containing or after a point")
  "ve" '(eval-expression :wk "Evaluate an elips expression")
  "vr" '(eval-region :wk "Evaluate elisp region"))

  (leader-keys
  "x" '(:ignore t :wk "Export")
  "xm" '(org-md-export-as-markdown :wk "Export as markdown"))

(leader-keys
"h" '(:ignore t :wk "Help")
"hf" '(describe-function :wk "Describe function")
"hv" '(describe-variable :wk "Describe variable"))

  (comment-leader-normal
 "" '(:ignore t :wk "Comment")
"c" '(comment-line :wk "Comment line"))

   )

(set-face-attribute 'default nil
:font "FiraMono Nerd Font"
:height 110
:weight 'medium)
(set-face-attribute 'variable-pitch nil
:font "Roboto"
:height 120
:weight 'medium)
(set-face-attribute 'fixed-pitch nil
:font "FiraMono Nerd Font"
:height 110
:weight 'medium)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
  (load-theme 'duskfox t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(global-visual-line-mode t)

(use-package which-key
  :init
    (which-key-mode t)
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 1.0
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit t
	  which-key-separator " → " ))

(use-package toc-org
:commands toc-org-enable
:init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))
