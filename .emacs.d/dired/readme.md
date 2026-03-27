
# Table of Contents

1.  [DIRED CONFIG](#org41aaf7f)
    1.  [Dired-Narrow](#orge8dc5d3)



<a id="org41aaf7f"></a>

# DIRED CONFIG

Functions

    (defun dired-go-home ()
      (interactive)
      (dired "~"))

Mappings

    (with-eval-after-load 'general
      (leader
        "e" 'dired))
    
    (with-eval-after-load 'evil
      (evil-define-key 'normal dired-mode-map
        "h" 'dired-up-directory
        "l" 'dired-find-file
        "d" 'dired-create-directory
        "n" 'dired-create-empty-file
        "D" 'dired-do-delete
        (kbd "<escape>") 'revert-buffer
        "gh" 'dired-go-home)
      )


<a id="orge8dc5d3"></a>

## Dired-Narrow

Mappings

    (with-eval-after-load 'evil
      (with-eval-after-load 'dired-narrow
        (evil-define-key 'normal dired-mode-map
          "s" 'dired-narrow)
        ))

