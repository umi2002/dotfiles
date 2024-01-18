#!/bin/bash

# read current battery capacity
current_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

# read current charging status
current_status=$(cat /sys/class/power_supply/BAT0/status)

echo "$current_capacity"
