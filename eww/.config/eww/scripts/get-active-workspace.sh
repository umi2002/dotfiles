#!/bin/bash

hyprctl monitors -j | jq --raw-output .[0].activeWorkspace.id
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | stdbuf -o0 awk -F '>>|,' '/^workspace>>/{print $2}'
