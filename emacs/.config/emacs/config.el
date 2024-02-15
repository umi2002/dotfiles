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
    (elpaca nil (message "deferred"))

(use-package general
  :config
  (general-evil-setup)
  (general-create-definer leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "M-SPC")

(general-define-key
:states '(normal visual)
  :keyamps 'override
"C-h" '(previous-buffer :wk "Previous buffer")
"C-l" '(next-buffer :wk "Next buffer")
"C-w" '(kill-this-buffer :wk "Kill this buffer"))
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

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(global-visual-line-mode t)
