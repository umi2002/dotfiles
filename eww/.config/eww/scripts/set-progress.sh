#!/bin/bash

FLAG_FILE="/tmp/user_action_flag"
if [ -f $FLAG_FILE ]; then
    echo $(playerctl -p spotify position $1)
fi
