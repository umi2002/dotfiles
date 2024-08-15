#!/bin/bash

playerctl -p chromium metadata mpris:length --follow | while read -r length; do
    echo "$((length / 1000000))"
done
