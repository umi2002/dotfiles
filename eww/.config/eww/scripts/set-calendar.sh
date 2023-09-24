#!/bin/bash

visible=$(eww get calendar-visible)

if [[ "$visible" == "true" ]] ; then
    eww update calendar-visible=false
    eww close calendar
else
    eww update calendar-visible=true
    eww open calendar
fi
