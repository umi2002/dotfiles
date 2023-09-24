#!/bin/bash

# Get the position (in seconds)
position_seconds=`playerctl -p spotify position`

# Get the length (in microseconds)
length_micros=`playerctl -p spotify metadata mpris:length`

# Convert the length to seconds
length_seconds=$(echo "$length_micros / 1000000" | bc -l)

# Format the position and length in minutes and seconds
position_minutes=$(printf "%02d" $(echo "$position_seconds / 60" | bc | cut -d'.' -f1))
position_secs=$(printf "%02d" $(echo "$position_seconds % 60" | bc | cut -d'.' -f1))
length_minutes=$(printf "%02d" $(echo "$length_seconds / 60" | bc | cut -d'.' -f1))
length_secs=$(printf "%02d" $(echo "$length_seconds % 60" | bc | cut -d'.' -f1))

# Print the position and length
echo "$position_minutes:$position_secs / $length_minutes:$length_secs"

