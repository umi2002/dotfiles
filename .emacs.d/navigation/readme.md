
# Table of Contents

1.  [NAVIGATION CONFIG](#org2da8f57)
    1.  [Helm](#org1ff7e30)
    2.  [Avy](#orgadd0ce6)



<a id="org2da8f57"></a>

# NAVIGATION CONFIG


<a id="org1ff7e30"></a>

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


<a id="orgadd0ce6"></a>

## Avy

Mappings

    (with-eval-after-load 'avy
      (leader
        "l" 'avy-goto-char-2)
      )

