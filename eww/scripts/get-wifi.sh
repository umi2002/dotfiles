#!/bin/bash

# Check for Wi-Fi connection
wifi_info=$(nmcli -t -f IN-USE,SSID,SIGNAL dev wifi)
wifi_status=$(echo "$wifi_info" | grep "^*")
current_signal_strength=$(echo $wifi_status | cut -d':' -f3)
current_wifi_name=$(echo $wifi_status | cut -d':' -f2)

# Check for Ethernet connection
ethernet_info=$(nmcli -t -f DEVICE,TYPE,STATE dev | grep "ethernet:connected")

# Output status
if [[ $ethernet_info != "" ]]; then
    echo "󰈁 Eth"
elif [[ $current_wifi_name != "" ]]; then
    # Categorize the Wi-Fi signal strength
    if [[ $current_signal_strength -ge 75 ]]; then
        current_wifi_name="󰤨 $current_wifi_name"
    elif [[ $current_signal_strength -ge 50 ]]; then
        current_wifi_name="󰤥 $current_wifi_name"
    elif [[ $current_signal_strength -ge 25 ]]; then
        current_wifi_name="󰤢 $current_wifi_name"
    else
        current_wifi_name="󰤟 $current_wifi_name"
    fi
    echo "$current_wifi_name"
else
    echo "󰤭 No Connection"
fi

