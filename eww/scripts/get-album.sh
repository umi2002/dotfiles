#!/bin/bash
#!/bin/bash

zscroll -l 22 \
    --delay 0.2 \
    --match-command "playerctl -p spotify status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-check true 'playerctl -p spotify metadata album'
