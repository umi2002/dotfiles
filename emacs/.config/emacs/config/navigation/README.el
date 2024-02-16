(use-package helm)
(elpaca-wait)

(use-package helm-ls-git
:after helm)
(elpaca-wait)

(use-package helm-projectile
:after (helm projectile))
(elpaca-wait)

(setq helm-move-to-line-cycle-in-source nil)

(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-j") 'helm-next-line)

(leader-key
"f" '(helm-projectile-find-file :wk "Find file")
"c f" '((lambda () (interactive) (find-file "~/.config/emacs/config/README.org")) :wk "Edit emacs config"))

(leader-key
  "b" '(:ignore t :wk "buffer")
  "bf" '(ibuffer :wk "Ibuffer")
  "bb" '(switch-to-buffer :wk "Switch buffer")
  "bk" '(kill-this-buffer :wk "Kill this buffer")
  "bn" '(next-buffer :wk "Next buffer")
  "bp" '(previous-buffer :wk "Previous buffer")
  "br" '(revert-buffer :wk "Reload buffer"))
