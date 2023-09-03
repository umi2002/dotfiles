#!/bin/bash

playerctl -p spotify status --follow | while read -r status ; do
    if [[ "$status" == "Playing" ]] ; then
        echo " "
    elif [[ "$status" == "Paused" ]] ; then
        echo " "
    fi
done
