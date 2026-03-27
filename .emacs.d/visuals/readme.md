
# Table of Contents

1.  [VISUALS CONFIG](#orgccf0764)
    1.  [Dimmer](#orgdc6f2e9)
    2.  [Telephone Line](#orgab604c3)
    3.  [Olivetti](#org50a4f05)
    4.  [Mixed-Pitch](#orgcd938e5)



<a id="orgccf0764"></a>

# VISUALS CONFIG


<a id="orgdc6f2e9"></a>

## Dimmer

    (with-eval-after-load 'dimmer
      (dimmer-configure-helm)
      (dimmer-mode t))


<a id="orgab604c3"></a>

## Telephone Line

    (with-eval-after-load 'telephone-line
      (telephone-line-mode 1))


<a id="org50a4f05"></a>

## Olivetti

    (setq olivetti-body-width 200)
    (with-eval-after-load 'olivetti
      (add-hook 'text-mode-hook #'olivetti-mode)
      (add-hook 'org-mode-hook #'olivetti-mode)
      (olivetti-mode 1))


<a id="orgcd938e5"></a>

## Mixed-Pitch

    (with-eval-after-load 'mixed-pitch
      (add-hook 'text-mode-hook #'mixed-pitch-mode))

