(with-eval-after-load 'org-faces
  (set-face-attribute 'org-default nil :family "Linux Libertine O" :height 120)
  (set-face-attribute 'org-block nil :family "FiraMono Nerd Font" :height 100)
  (set-face-attribute 'org-meta-line nil :family "FiraMono Nerd Font" :height 100))
(setq org-startup-with-inline-images t)

(with-eval-after-load 'general
  (general-create-definer org
    :wrapping leader
    :infix "o")

  (org
    "a" 'org-agenda))

(defun cleanup-org-results ()
  (when (eq major-mode 'org-mode)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "^#\\+RESULTS:.*\n.*\n\n" nil t)
	(replace-match "")))))

(defun indent-whole-buffer ()
  (indent-region (point-min) (point-max)))

(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook #'indent-whole-buffer nil t)
	    (add-hook 'before-save-hook #'cleanup-org-results nil t)))

(with-eval-after-load 'toc-org
  (if (require 'toc-org nil t)
      (progn
	(add-hook 'org-mode-hook 'toc-org-mode))
    (warn "toc-org not found")))

(with-eval-after-load 'org-modern
  (add-hook 'org-mode-hook #'org-modern-mode)
  (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))

(with-eval-after-load 'org-roam
  (defun my/org-font ()
    (when (org-roam-buffer-p)
      (buffer-face-set :family "Andika" :height 120)))

  (add-hook 'org-mode-hook 'my/org-font)
  (setq org-roam-directory (file-truename "~/umiwiki"))
  (org-roam-db-autosync-mode)

  (general-create-definer node
    :keymaps '(global override)
    :wrapping leader
    :infix "n")

  (node
    "i" 'org-roam-node-insert
    "f" 'org-roam-node-find
    "c" 'org-roam-capture))

(setq org-directory "~/Documents/org")
(setq org-agenda-files (list "dailies.org" "birthdays.org"))
(defun org-habit-streak-count ()
  (goto-char (point-min))
  (while (not (eobp))
    ;;on habit line?
    (when (get-text-property (point) 'org-habit-p)
      (let ((streak 0)
	    (counter (+ org-habit-graph-column (- org-habit-preceding-days org-habit-following-days))))
	(move-to-column counter)
	;;until end of line
	(while (= (char-after (point)) org-habit-completed-glyph)
	  (setq streak (+ streak 1))
	  (setq counter (- counter 1))
	  (backward-char 1))
	(end-of-line)
	(insert (number-to-string streak))))
    (forward-line 1)))
(add-hook 'org-agenda-finalize-hook 'org-habit-streak-count)
(add-hook 'org-todo-repeat-hook #'org-reset-checkbox-state-subtree)

(with-eval-after-load 'evil
  (evil-set-initial-state 'org-agenda-mode 'normal))

(with-eval-after-load 'general
  (general-define-key
   :states '(normal)
   :keymaps '(org-agenda-mode-map)
   "h" 'org-agenda-earlier
   "l" 'org-agenda-later
   "b" 'org-agenda-earlier
   "." 'org-agenda-goto-today
   "t" 'org-agenda-todo
   "r" 'org-agenda-redo
   "m" 'org-agenda-month-view
   "w" 'org-agenda-week-view
   "d" 'org-agenda-day-view
   "f" 'org-agenda-filter
   "RET" 'org-agenda-goto))
