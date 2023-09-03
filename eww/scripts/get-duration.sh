#!/bin/bash

playerctl -p spotify metadata mpris:length --follow | while read -r length; do
    echo "$((length / 1000000))"
done
