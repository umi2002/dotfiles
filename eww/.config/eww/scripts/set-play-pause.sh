#!/bin/bash

status=$(playerctl -p chromium status)
if [[ "$status" == "Playing" ]] ; then
    playerctl -p chromium pause
elif [[ "$status" == "Paused" ]] ; then
    playerctl -p chromium play
fi
