(org-babel-load-file
 (expand-file-name
  "settings.org"
  user-emacs-directory))

(defvar elpaca-installer-version 0.9)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
			      :ref nil :depth 1 :inherit ignore
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
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;; (elpaca example-package)

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode)
  (setq elpaca-use-package-by-default t))

(elpaca-wait)

(setq evil-want-keybinding nil)

(use-package evil)

(use-package evil-collection
  :after evil)

(org-babel-load-file
 (expand-file-name
  "evil/config.org"
  user-emacs-directory))

(use-package general :demand t)

(org-babel-load-file
 (expand-file-name
  "general/config.org"
  user-emacs-directory))

(use-package helm)

(use-package helm-rg
  :after helm)

(use-package avy)

(org-babel-load-file
 (expand-file-name
  "navigation/config.org"
  user-emacs-directory))

(use-package projectile)

(use-package helm-projectile
  :after (helm projectile))

(org-babel-load-file
 (expand-file-name
  "project/config.org"
  user-emacs-directory))

(use-package lsp-mode
  :commands (lsp lsp-deferred))

(use-package company)

(use-package helm-xref
  :after helm)

(use-package helm-lsp
  :after (helm lsp-mode))

(use-package yasnippet)

(use-package format-all)

(use-package flycheck)

(use-package helm-flycheck
  :after (helm flycheck))

(use-package flycheck-inline
  :after flycheck)

(org-babel-load-file
 (expand-file-name
  "lsp/config.org"
  user-emacs-directory))

(use-package evil-surround
  :after evil)

(use-package embrace)

(use-package evil-embrace
  :after (evil-surround embrace))

(use-package evil-commentary
  :after evil)

(use-package evil-goggles
  :after evil)

(use-package vterm)

(use-package undo-tree)

(org-babel-load-file
 (expand-file-name
  "utils/config.org"
  user-emacs-directory))

(use-package transient)

(use-package magit)

(use-package git-gutter)

(org-babel-load-file
 (expand-file-name
  "git/config.org"
  user-emacs-directory))

(use-package doom-themes
  :config (load-theme 'doom-palenight t))

(use-package dimmer)

(use-package telephone-line)

(use-package visual-fill-column)

(org-babel-load-file
 (expand-file-name
  "visuals/config.org"
  user-emacs-directory))

(use-package toc-org
  :after org)

(use-package org-modern
  :after org)

(use-package org-roam
  :after org)

(use-package org-download)

(org-babel-load-file
 (expand-file-name
  "org/config.org"
  user-emacs-directory))
