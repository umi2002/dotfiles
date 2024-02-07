#!/bin/bash

playerctl -p spotify metadata mpris:artUrl --follow | while read -r art ; do
    curl -o /tmp/spotfy-art.png "$art"
    eww update song-path=/tmp/spotfy-art.png
