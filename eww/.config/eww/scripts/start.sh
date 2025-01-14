#!/bin/bash

eww kill

monitors=$(hyprctl monitors -j | jq '.[] | .id')

for monitor in ${monitors}; do
    eww open top${monitor}
    eww open bottom${monitor}
done
