#!/bin/bash

zscroll -l 25 \
    --delay 0.2 \
    --match-command "playerctl -p chromium status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-check true 'playerctl -p chromium metadata --format "{{ title }}   {{ artist }}"'
