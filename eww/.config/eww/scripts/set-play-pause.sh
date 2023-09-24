#!/bin/bash

status=$(playerctl -p spotify status)
if [[ "$status" == "Playing" ]] ; then
    playerctl -p spotify pause
elif [[ "$status" == "Paused" ]] ; then
    playerctl -p spotify play
fi
