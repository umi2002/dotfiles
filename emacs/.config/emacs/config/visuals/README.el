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
