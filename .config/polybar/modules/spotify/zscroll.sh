#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll -l 10 \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "`dirname $0`/spotify-script.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "`dirname $0`/spotify-script.sh" &

wait
