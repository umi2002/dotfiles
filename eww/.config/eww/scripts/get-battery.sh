#!/bin/bash

# read current battery capacity
current_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

# read current charging status
current_status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$current_status" == "Discharging" ]; then
    eww update battery-status=false
else
    eww update battery-status=true
fi

echo "$current_capacity"
