#!/bin/bash

# Function to handle ACPI events
handle_acpi_event() {
    local event=$1

    # Check for AC plug/unplug events
    if [[ "$event" == "ac_adapter ACPI0003:00 00000080 00000000" ]]; then
        echo 0
    elif [[ "$event" == "ac_adapter ACPI0003:00 00000080 00000001" ]]; then
        echo 1
    fi
}

# Listen for ACPI events
acpi_listen | while read -r event; do
    handle_acpi_event "$event"
done

