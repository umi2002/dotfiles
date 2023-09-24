#!/bin/bash

visible=$(eww get art-visible)

if [[ "$visible" == "true" ]] ; then
    eww update art-visible=false
else
    eww update art-visible=true
fi
