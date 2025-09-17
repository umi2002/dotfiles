#!/bin/bash

if [ $# -eq 0 ]; then
    exit 1
fi

get_app_icon() {
    local window_address="$1"
    
    local window_class=$(hyprctl clients -j | jq -r ".[] | select(.address==\"$window_address\") | .class")
    
    if [ -z "$window_class" ] || [ "$window_class" = "null" ]; then
        return 1
    fi
    
    local icon_name=$(find /usr/share/applications ~/.local/share/applications -name "*.desktop" -exec grep -l "StartupWMClass=$window_class" {} \; 2>/dev/null | head -1 | xargs grep "^Icon=" 2>/dev/null | cut -d'=' -f2)
    
    if [ -z "$icon_name" ]; then
        icon_name="$window_class"
    fi
    
    local icon_path=$(find /usr/share/icons /usr/share/pixmaps -name "${icon_name}.*" 2>/dev/null | head -1)
    
    if [ -n "$icon_path" ]; then
        echo "$icon_path"
        return 0
    else
        return 1
    fi
}

paths=()
for window_address in "$@"; do
    result=$(get_app_icon "$window_address")
    if [ $? -eq 0 ]; then
        paths+=("\"$result\"")
    fi
done

printf "["
for i in "${!paths[@]}"; do
    if [ $i -eq $((${#paths[@]} - 1)) ]; then
        # Last element - no comma
        printf "%s" "${paths[$i]}"
    else
        # Not last element - add comma
        printf "%s," "${paths[$i]}"
    fi
done
printf "]\n"
