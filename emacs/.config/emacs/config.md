
# Table of Contents

1.  [IMPORTANT PROGRAMS TO LOAD FIRST](#orgb9da6b9)
    1.  [Elpaca Package Manager](#orgcf7ab0a)
    2.  [Load Evil Mode](#org6bd3eb0)
    3.  [General Keybindings](#org2b27dd5)
2.  [FONTS](#org3adfc31)
3.  [GRAPHICAL USER INTERFACE TWEAKS](#org57d9534)
    1.  [Theme](#orgacfdc60)
    2.  [Disable Menubar, Toolbars and Scrollbars](#org18f2ed2)
    3.  [Display relative line numbers and truncated lines](#org541db7d)
4.  [WHICH-KEY](#orgaa14ce3)
5.  [ORG MODE](#org2b722cc)
    1.  [Enable Table of Contents](#orgc869625)
    2.  [Enable Org Bullets](#orga8ab068)



<a id="orgb9da6b9"></a>

# IMPORTANT PROGRAMS TO LOAD FIRST


<a id="orgcf7ab0a"></a>

## Elpaca Package Manager

    (defvar elpaca-installer-version 0.6)
    (defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
    (defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
    (defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
    (defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                                  :ref nil
                                  :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                                  :build (:not elpaca--activate-package)))
    (let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
           (build (expand-file-name "elpaca/" elpaca-builds-directory))
           (order (cdr elpaca-order))
           (default-directory repo))
      (add-to-list 'load-path (if (file-exists-p build) build repo))
      (unless (file-exists-p repo)
        (make-directory repo t)
        (when (< emacs-major-version 28) (require 'subr-x))
        (condition-case-unless-debug err
            (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                     ((zerop (call-process "git" nil buffer t "clone"
                                           (plist-get order :repo) repo)))
                     ((zerop (call-process "git" nil buffer t "checkout"
                                           (or (plist-get order :ref) "--"))))
                     (emacs (concat invocation-directory invocation-name))
                     ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                           "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                     ((require 'elpaca))
                     ((elpaca-generate-autoloads "elpaca" repo)))
                (progn (message "%s" (buffer-string)) (kill-buffer buffer))
              (error "%s" (with-current-buffer buffer (buffer-string))))
          ((error) (warn "%s" err) (delete-directory repo 'recursive))))
      (unless (require 'elpaca-autoloads nil t)
        (require 'elpaca)
        (elpaca-generate-autoloads "elpaca" repo)
        (load "./elpaca-autoloads")))
    (add-hook 'after-init-hook #'elpaca-process-queues)
    (elpaca `(,@elpaca-order))


<a id="org6bd3eb0"></a>

## Load Evil Mode

        ;; Install a package via the elpaca macro
        ;; See the "recipes" section of the manual for more details.
    
        ;; (elpaca example-package)
    
        ;; Install use-package support
        (elpaca elpaca-use-package
          ;; Enable use-package :ensure support for Elpaca.
          (elpaca-use-package-mode)
      (setq elpaca-use-package-by-default t))
        ;; Block until current queue processed.
        (elpaca-wait)
    
        ;;When installing a package which modifies a form used at the top-level
        ;;(e.g. a package which adds a use-package key word),
        ;;use `elpaca-wait' to block until that package has been installed/configured.
        ;;For example:
        ;;(use-package general :ensure t :demand t)
        ;;(elpaca-wait)
    
        ;; Expands to: (elpaca evil (use-package evil :demand t))
    (use-package evil
        :init
        (setq evil-want-integration t)
        (setq evil-want-keybinding nil)
        (setq evil-vsplit-window-right t)
        (setq evil-split-window-below t)
        (evil-mode))
      (use-package evil-collection
        :after evil
        :config
        (setq evil-collection-mode-list '(dashboard dired ibuffer))
        (evil-collection-init))
    
        ;;Turns off elpaca-use-package-mode current declaration
        ;;Note this will cause the declaration to be interpreted immediately (not deferred).
        ;;Useful for configuring built-in emacs features.
        (use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))
    
        ;; Don't install anything. Defer execution of BODY
        ;;(elpaca nil (message "deferred"))


<a id="org2b27dd5"></a>

## General Keybindings

      (use-package general
      :config
      (general-evil-setup)
      (general-create-definer leader-keys
      :states '(normal insert visual emacs)
      :keymaps 'override
      :prefix "SPC"
      :global-prefix "M-SPC")
    
    (leader-keys
    "f" '(find-file :wk "Find file")
    "c f" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config"))
    
    (leader-keys
      "b" '(:ignore t :wk "buffer")
      "bi" '(ibuffer :wk "Ibuffer")
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
    
    )


<a id="org3adfc31"></a>

# FONTS

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


<a id="org57d9534"></a>

# GRAPHICAL USER INTERFACE TWEAKS


<a id="orgacfdc60"></a>

## Theme

    (add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
      (load-theme 'duskfox t)


<a id="org18f2ed2"></a>

## Disable Menubar, Toolbars and Scrollbars

    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)


<a id="org541db7d"></a>

## Display relative line numbers and truncated lines

    (global-display-line-numbers-mode t)
    (setq display-line-numbers-type 'relative)
    (global-visual-line-mode t)


<a id="orgaa14ce3"></a>

# WHICH-KEY

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


<a id="org2b722cc"></a>

# ORG MODE


<a id="orgc869625"></a>

## Enable Table of Contents

    (use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))


<a id="orga8ab068"></a>

## Enable Org Bullets

    (add-hook 'org-mode-hook 'org-indent-mode)
    (use-package org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode t)))

