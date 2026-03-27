
# Table of Contents

1.  [UTILS CONFIG](#org3359d7c)
    1.  [Evil-Surround](#orgc6d14b7)
    2.  [Evil-Embrace](#orgb440acd)
    3.  [Evil-Commentary](#org39d4836)
    4.  [Evil-Goggles](#org81f3fe4)
    5.  [Vterm](#org3ae5bfb)
    6.  [Undo-Tree](#org6acec21)
    7.  [Exec-Path-From-Shell](#org98713e7)



<a id="org3359d7c"></a>

# UTILS CONFIG


<a id="orgc6d14b7"></a>

## Evil-Surround

    (with-eval-after-load 'evil-surround
      (global-evil-surround-mode 1))


<a id="orgb440acd"></a>

## Evil-Embrace

Setup

    (with-eval-after-load 'evil-embrace
      (evil-embrace-enable-evil-surround-integration))

Mappings

    (with-eval-after-load 'evil-embrace
      (general-create-definer surround
        :keymaps '(global override)
        :wrapping leader
        :infix "s")
    
      (surround
        "r" 'evil-embrace-evil-surround-change)
      )


<a id="org39d4836"></a>

## Evil-Commentary

Setup

    (with-eval-after-load 'evil-commentary
      (evil-commentary-mode))


<a id="org81f3fe4"></a>

## Evil-Goggles

    (with-eval-after-load 'evil-goggles
      (evil-goggles-mode)
      (setq evil-goggles-duration 0.500)
      )


<a id="org3ae5bfb"></a>

## Vterm

Functions

    (defun toggle-vterm ()
      "Toggle between vterm and current buffer."
      (interactive)
      (if (string= major-mode "vterm-mode")
          (evil-switch-to-windows-last-buffer)
        (if (get-buffer "vterm")
            (switch-to-buffer "vterm")
          (vterm))))

Mappings

    (with-eval-after-load 'vterm
      (leader
        "`" 'toggle-vterm)
      )


<a id="org6acec21"></a>

## Undo-Tree

Setup

    (with-eval-after-load 'undo-tree
      (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
      (global-undo-tree-mode))

Mappings

    (with-eval-after-load 'undo-tree
      (general-define-key
       :states 'normal
       "u" 'undo-tree-undo
       "C-r" 'undo-tree-redo)
    
      (leader
        "u" 'undo-tree-visualize)
      )


<a id="org98713e7"></a>

## Exec-Path-From-Shell

    (with-eval-after-load 'exec-path-from-shell
      (when (memq window-system '(mac ns x))
        (exec-path-from-shell-initialize)))

