#!/bin/bash

playerctl -p cider status --follow | while read -r status ; do
    if [[ "$status" == "Playing" ]] ; then
        echo " "
    elif [[ "$status" == "Paused" ]] ; then
        echo " "
    fi
done
