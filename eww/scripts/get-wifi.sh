#!/bin/bash

wifi_info=$(nmcli -t -f IN-USE,SSID,SIGNAL dev wifi)
wifi_status=$(echo "$wifi_info" | grep "^*")
current_signal_strength=$(echo $wifi_status | cut -d':' -f3)
current_wifi_name=$(echo $wifi_status | cut -d':' -f2)

# Categorize the signal strength
if [[ $current_wifi_name == "" ]]; then
    current_wifi_name="󰤭 No WiFi"
elif [[ $current_signal_strength -ge 75 ]]; then
    current_wifi_name="󰤨 $current_wifi_name"
elif [[ $current_signal_strength -ge 50 ]]; then
    current_wifi_name="󰤥 $current_wifi_name"
elif [[ $current_signal_strength -ge 25 ]]; then
    current_wifi_name="󰤢 $current_wifi_name"
else
    current_wifi_name="󰤟 $current_wifi_name"
fi

echo "$current_wifi_name"
