#!/bin/bash

# Function to handle ACPI events
handle_acpi_event() {
    local status=$(cat /sys/class/power_supply/BAT0/status)

    # Check for AC plug/unplug events
    if [[ "$status" == "Charging" ]]; then
        echo 1
    else
        echo 0
    fi
}

handle_acpi_event

# Listen for ACPI events
acpi_listen | while read -r event; do
    handle_acpi_event
done

