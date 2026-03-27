
# Table of Contents

1.  [MY CONFIG](#org1d7bf4c)
    1.  [EDITOR SETTINGS](#org1e6ec5b)
    2.  [IMPORTANT PROGRAMS TO LOAD FIRST](#orge62384d)
        1.  [Elpaca Package Manager](#org8479b0a)
        2.  [Evil](#orgb90be8b)
        3.  [General](#org04b14d9)
    3.  [DIRED](#org3f28482)
    4.  [NAVIGATION](#org7b99875)
    5.  [PROJECT](#org25c4c78)
    6.  [LSP](#orgb45cbe1)
    7.  [UTILS](#orgf1519f6)
    8.  [GIT](#org5db0796)
    9.  [VISUALS](#orga049d63)
    10. [ORG](#orgd26d07a)



<a id="org1d7bf4c"></a>

# MY CONFIG


<a id="org1e6ec5b"></a>

## EDITOR SETTINGS

[Configuration](settings/readme.md)

    (org-babel-load-file
     (expand-file-name
      "settings/readme.org"
      user-emacs-directory))


<a id="orge62384d"></a>

## IMPORTANT PROGRAMS TO LOAD FIRST


<a id="org8479b0a"></a>

### Elpaca Package Manager

Installing Elpaca

    (defvar elpaca-installer-version 0.12)
    (defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
    (defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
    (defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
    (defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                                  :ref nil :depth 1 :inherit ignore
                                  :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                                  :build (:not elpaca-activate)))
    (let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
           (build (expand-file-name "elpaca/" elpaca-builds-directory))
           (order (cdr elpaca-order))
           (default-directory repo))
      (add-to-list 'load-path (if (file-exists-p build) build repo))
      (unless (file-exists-p repo)
        (make-directory repo t)
        (when (<= emacs-major-version 28) (require 'subr-x))
        (condition-case-unless-debug err
            (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                      ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                      ,@(when-let* ((depth (plist-get order :depth)))
                                                          (list (format "--depth=%d" depth) "--no-single-branch"))
                                                      ,(plist-get order :repo) ,repo))))
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
        (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
    (add-hook 'after-init-hook #'elpaca-process-queues)
    (elpaca `(,@elpaca-order))

Enable the Elpaca use-package macro

    ;; Install a package via the elpaca macro
    ;; See the "recipes" section of the manual for more details.
    
    ;; (elpaca example-package)
    
    ;; Install use-package support
    (elpaca elpaca-use-package
      ;; Enable use-package :ensure support for Elpaca.
      (elpaca-use-package-mode)
      (setq elpaca-use-package-by-default t))

Wait for Elpaca to be installed

    (elpaca-wait)


<a id="orgb90be8b"></a>

### Evil

Unsetting evil-want-keybinding

    (setq evil-want-keybinding nil)

Installing Evil

    (use-package evil)

Installing Evil-Collection

    (use-package evil-collection
      :after evil)

[Configuration](evil/readme.md)

    (org-babel-load-file
     (expand-file-name
      "evil/readme.org"
      user-emacs-directory))


<a id="org04b14d9"></a>

### General

Installing General 

    (use-package general :demand t)

[Configuration](general/readme.md)

    (org-babel-load-file
     (expand-file-name
      "general/readme.org"
      user-emacs-directory))


<a id="org3f28482"></a>

## DIRED

Installing Dired-Narrow

    (use-package dired-narrow)

[Configuration](dired/readme.md)

    (org-babel-load-file
     (expand-file-name
      "dired/readme.org"
      user-emacs-directory))


<a id="org7b99875"></a>

## NAVIGATION

Installing Helm

    (use-package helm)

Installing Helm-Rg

    (use-package helm-rg
      :after helm)

Installing Avy

    (use-package avy)

[Configuration](navigation/readme.md)

    (org-babel-load-file
     (expand-file-name
      "navigation/readme.org"
      user-emacs-directory))


<a id="org25c4c78"></a>

## PROJECT

[Configuration](project/readme.md)

    (org-babel-load-file
     (expand-file-name
      "project/readme.org"
      user-emacs-directory))


<a id="orgb45cbe1"></a>

## LSP

Installing Lsp-Mode

    (use-package lsp-mode
      :commands (lsp lsp-deferred))

Installing Lsp-UI

    (use-package lsp-ui)

Installing Company

    (use-package company)

Installing Helm-Xref

    (use-package helm-xref
      :after helm)

Installing Helm-Lsp

    (use-package helm-lsp
      :after (helm lsp-mode))

Installing Yasnippet

    (use-package yasnippet)

Installing Format-All

    (use-package format-all)

Installing Flycheck

    (use-package flycheck)

Installing Helm-Flycheck

    (use-package helm-flycheck
      :after (helm flycheck))

Installing Flycheck-Inline

    (use-package flycheck-inline
      :after flycheck)

[Configuration](lsp/readme.md)

    (org-babel-load-file
     (expand-file-name
      "lsp/readme.org"
      user-emacs-directory))


<a id="orgf1519f6"></a>

## UTILS

Installing Evil-Surround

    (use-package evil-surround
      :after evil)

Installing Embrace

    (use-package embrace)

Installing Evil-Embrace

    (use-package evil-embrace
      :after (evil-surround embrace))

Intalling Evil-Commentary

    (use-package evil-commentary
      :after evil)

Installing Evil-Goggles

    (use-package evil-goggles
      :after evil)

Installing Vterm

    (use-package vterm)

Installing Undo-Tree

    (use-package undo-tree)

Installing Exec-Path-From-Shell

    (use-package exec-path-from-shell)

[Configuration](utils/readme.md)

    (org-babel-load-file
     (expand-file-name
      "utils/readme.org"
      user-emacs-directory))


<a id="org5db0796"></a>

## GIT

Installing Transient

    (use-package transient)

Installing Magit

    (use-package magit)

Installing Git-Gutter

    (use-package git-gutter)

[Configuration](git/readme.md)

    (org-babel-load-file
     (expand-file-name
      "git/readme.org"
      user-emacs-directory))


<a id="orga049d63"></a>

## VISUALS

Installing Catppuccin-Theme

    (use-package catppuccin-theme
      :config (load-theme 'catppuccin :noconfirm))

Installing Dimmer

    (use-package dimmer)

Installing Telephone Line

    (use-package telephone-line)

Installing Olivetti

    (use-package olivetti)

Installing All-The-Icons

    (use-package all-the-icons
      :if (display-graphic-p))

Installing Mixed-Pitch

    (use-package mixed-pitch)

[Configuration](visuals/readme.md)

    (org-babel-load-file
     (expand-file-name
      "visuals/readme.org"
      user-emacs-directory))


<a id="orgd26d07a"></a>

## ORG

Installing Toc-Org

    (use-package toc-org
      :after org)

Installing Org-Modern

    (use-package org-modern
      :after org)

Installing Org-Roam

    (use-package org-roam
      :after org)

Installing Org-Download

    (use-package org-download)

Installing Org-Fragtog

    (use-package org-fragtog
      :after org)

[Configuration](org/readme.md)

    (org-babel-load-file
     (expand-file-name
      "org/readme.org"
      user-emacs-directory))

