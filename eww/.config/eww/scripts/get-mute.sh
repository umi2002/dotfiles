#!/bin/bash

# Function to check if the default sink is muted
check_mute() {
    # Get the default sink name
    local sink=$(pactl get-default-sink)

    # Check if the default sink is muted
    pactl get-sink-mute "$sink" | grep 'Mute: yes' &> /dev/null
    echo "$?"
}

# Initial check
check_mute

# Monitor changes in PulseAudio
pactl subscribe | grep --line-buffered 'sink ' | while read -r line; do
    check_mute
done
