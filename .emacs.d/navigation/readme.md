
# Table of Contents

1.  [NAVIGATION CONFIG](#orgb858db9)
    1.  [Helm](#org33593ff)
    2.  [Avy](#org113331f)



<a id="orgb858db9"></a>

# NAVIGATION CONFIG


<a id="org33593ff"></a>

## Helm

Setup

    (with-eval-after-load 'helm
      (helm-mode 1)
      (setq helm-completion-style 'helm-fuzzy)
      )

Mappings

    (with-eval-after-load 'helm
      (general-define-key
       :keymaps 'helm-map
       "C-w" 'backward-kill-word
       "C-j" 'helm-next-line
       "C-k" 'helm-previous-line)
    
      (buffer
        "f" 'helm-buffers-list)
      )


<a id="org113331f"></a>

## Avy

Mappings

    (with-eval-after-load 'avy
      (leader
        "l" 'avy-goto-char-2)
      )

