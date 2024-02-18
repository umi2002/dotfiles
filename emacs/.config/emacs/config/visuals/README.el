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

(with-eval-after-load 'company
  (custom-set-faces
   '(company-tooltip ((t (:background "#232136" :foreground "#e0def4"))))
   '(company-tooltip-selection ((t (:background "#47407d" :foreground "#e2e0f7"))))
   '(company-tooltip-common ((t (:foreground "#f083a2"))))
   '(company-tooltip-common-selection ((t (:foreground "#f083a2"))))
   '(company-scrollbar-fg ((t (:background "#569fba"))))
   '(company-scrollbar-bg ((t (:background "#393552"))))
   '(company-preview-common ((t (:foreground "#a6dae3" :background "#232136"))))))

(with-eval-after-load 'git-gutter
  (set-face-foreground 'git-gutter:modified "yellow")
  (set-face-background 'git-gutter:modified "#232136")
  (set-face-foreground 'git-gutter:added "green")
  (set-face-background 'git-gutter:added "#232136")
  (set-face-foreground 'git-gutter:deleted "red")
  (set-face-background 'git-gutter:deleted "#232136"))
