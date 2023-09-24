#!/bin/bash

status=$(eww get volume-visible)

if [[ "$status" == "true" ]]; then
    eww update volume-visible=false
else
    eww update volume-visible=true
fi
