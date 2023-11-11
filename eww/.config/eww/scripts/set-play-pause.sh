#!/bin/bash

status=$(playerctl -p cider status)
if [[ "$status" == "Playing" ]] ; then
    playerctl -p cider pause
elif [[ "$status" == "Paused" ]] ; then
    playerctl -p cider play
fi
