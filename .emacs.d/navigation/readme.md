
# Table of Contents

1.  [NAVIGATION CONFIG](#org5e0dffb)
    1.  [Helm](#org6803740)
    2.  [Avy](#org5b02e12)



<a id="org5e0dffb"></a>

# NAVIGATION CONFIG


<a id="org6803740"></a>

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


<a id="org5b02e12"></a>

## Avy

Mappings

    (with-eval-after-load 'avy
      (leader
        "l" 'avy-goto-char-2)
      )

