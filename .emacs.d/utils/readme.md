
# Table of Contents

1.  [UTILS CONFIG](#org43462af)
    1.  [Evil-Surround](#orgf6c1532)
    2.  [Evil-Embrace](#orgf2f5daf)
    3.  [Evil-Commentary](#orgbec6a11)
    4.  [Evil-Goggles](#org016052f)
    5.  [Vterm](#orga66ded5)
    6.  [Undo-Tree](#org89766fc)
    7.  [Exec-Path-From-Shell](#orgd9b9649)



<a id="org43462af"></a>

# UTILS CONFIG


<a id="orgf6c1532"></a>

## Evil-Surround

    (with-eval-after-load 'evil-surround
      (global-evil-surround-mode 1))


<a id="orgf2f5daf"></a>

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


<a id="orgbec6a11"></a>

## Evil-Commentary

Setup

    (with-eval-after-load 'evil-commentary
      (evil-commentary-mode))


<a id="org016052f"></a>

## Evil-Goggles

    (with-eval-after-load 'evil-goggles
      (evil-goggles-mode)
      (setq evil-goggles-duration 0.500)
      )


<a id="orga66ded5"></a>

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


<a id="org89766fc"></a>

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


<a id="orgd9b9649"></a>

## Exec-Path-From-Shell

    (with-eval-after-load 'exec-path-from-shell
      (when (memq window-system '(mac ns x))
        (exec-path-from-shell-initialize)))

