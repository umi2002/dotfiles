#!/bin/bash

open_bars() {
    eww close-all

    monitors=$(hyprctl monitors -j | jq '.[] | .id')

    for monitor in ${monitors}; do
        eww open top${monitor}
        eww open bottom${monitor}
    done
}

open_bars

udevadm monitor --subsystem-match=drm | while read line; do
    if [[ $line == *"UDEV"* ]] && [[ $line == *"change"* ]]; then
        open_bars
    fi
done
