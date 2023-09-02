#!/bin/bash

pactl subscribe | grep --line-buffered "sink #" | while read -r line;
do
    active_sink=$(pactl info | grep "Default Sink" | cut -d ' ' -f3)
    pactl list sinks | grep -A 15 -e "$active_sink" | grep '^[[:space:]]Volume:' | head -n 1 | sed 's|.*[[:space:]]\([[:digit:]]\+\)%.*|\1|';
done
