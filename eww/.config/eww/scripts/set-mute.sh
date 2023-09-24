#!/bin/bash

amixer set Master toggle

output=$(amixer sget Master)
status=$(echo "$output" | grep -E -o '\[on\]|\[off\]' | awk -F '[]\[]+' '{print $2}' | head -n 1)

if [[ "$status" == "on" ]]; then
    eww update muted=false
else
    eww update muted=true
fi
