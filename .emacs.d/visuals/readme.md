
# Table of Contents

1.  [VISUALS CONFIG](#org0ff1893)
    1.  [Dimmer](#org16dccb4)
    2.  [Telephone Line](#org3fae41d)
    3.  [Olivetti](#org733b379)
    4.  [Mixed-Pitch](#org3083011)



<a id="org0ff1893"></a>

# VISUALS CONFIG


<a id="org16dccb4"></a>

## Dimmer

    (with-eval-after-load 'dimmer
      (dimmer-configure-helm)
      (dimmer-mode t))


<a id="org3fae41d"></a>

## Telephone Line

    (with-eval-after-load 'telephone-line
      (telephone-line-mode 1))


<a id="org733b379"></a>

## Olivetti

    (setq olivetti-body-width 200)
    (with-eval-after-load 'olivetti
      (add-hook 'text-mode-hook #'olivetti-mode)
      (add-hook 'org-mode-hook #'olivetti-mode)
      (olivetti-mode 1))


<a id="org3083011"></a>

## Mixed-Pitch

    (with-eval-after-load 'mixed-pitch
      (add-hook 'text-mode-hook #'mixed-pitch-mode))

