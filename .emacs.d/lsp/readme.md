
# Table of Contents

1.  [COMPLETION](#org9272a3d)
    1.  [Company-Mode](#orgd822339)
2.  [DIAGNOSTICS](#orgd27837b)
    1.  [Flycheck](#orgc71eabc)
    2.  [Helm-Flycheck](#orge5acf2f)
    3.  [Flycheck-Inline](#org426d3e8)
3.  [FORMATTING](#orga5fddcf)
    1.  [Format-All-Mode](#org1a8b35f)



<a id="org9272a3d"></a>

# COMPLETION


<a id="orgd822339"></a>

## Company-Mode

Setup

    (with-eval-after-load 'company
      (setq company-minimum-prefix-length 1)
      (global-company-mode))

Mappings

    (with-eval-after-load 'company
      (general-define-key
       :keymaps '(company-active-map)
       "<tab>" 'company-complete-selection
       "RET" nil))

Setup

    (with-eval-after-load 'yasnippet
      (yas-global-mode 1))


<a id="orgd27837b"></a>

# DIAGNOSTICS

Mappings

    (with-eval-after-load 'flycheck
      (general-create-definer diagnostics
        :keymaps '(global override)
        :wrapping leader
        :infix "d")
    
      (diagnostics
        "j" 'flycheck-next-error
        "k" 'flycheck-previous-error))


<a id="orgc71eabc"></a>

## Flycheck

Setup

    (with-eval-after-load 'flycheck
      (add-hook 'after-init-hook #'global-flycheck-mode))


<a id="orge5acf2f"></a>

## Helm-Flycheck

Mappings

    (with-eval-after-load 'flycheck
      (diagnostics
        "t" 'helm-flycheck))


<a id="org426d3e8"></a>

## Flycheck-Inline

Setup

    (with-eval-after-load 'flycheck
      (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))


<a id="orga5fddcf"></a>

# FORMATTING


<a id="org1a8b35f"></a>

## Format-All-Mode

    (with-eval-after-load 'format-all
      (add-hook 'prog-mode-hook 'format-all-mode))

