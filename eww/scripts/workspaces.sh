#!/bin/bash

ws1="1"
ws2="2"
ws3="3"
ws4="4"
ws5="5"
ws6="6"
ws7="7"
ws8="8"
ws9="9"
ws10="10"

# check if Occupied
o1=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws1" )
o2=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws2" )
o3=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws3" )
o4=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws4" )
o5=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws5" )
o6=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws6" )
o7=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws7" )
o8=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws8" )
o9=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws9" )
o10=$(hyprctl workspaces -j | jq -r '.[] | .name' | grep -x "$ws10" )

# check if Focused
f1=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws1" )
f2=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws2" )
f3=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws3" )
f4=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws4" )
f5=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws5" )
f6=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws6" )
f7=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws7" )
f8=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws8" )
f9=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws9" )
f10=$(hyprctl activeworkspace -j | jq -r .id| grep -x "$ws10" )

ic_1=""
ic_2=""
ic_3=""
ic_4=""
ic_5=""
ic_6=""
ic_7=""
ic_8=""
ic_9=""
ic_10=""

if [ $o1 ]; then
    ic_1=""
fi
if [ $o2 ]; then
    ic_2=""
fi
if [ $o3 ]; then
    ic_3=""
fi
if [ $o4 ]; then
    ic_4=""
fi
if [ $o5 ]; then
    ic_5=""
fi
if [ $o6 ]; then
    ic_6=""
fi
if [ $o7 ]; then
    ic_7=""
fi
if [ $o8 ]; then
    ic_8=""
fi
if [ $o9 ]; then
    ic_9=""
fi
if [ $o10 ]; then
    ic_10=""
fi

if [ $f1 ]; then
    ic_1=""
elif [ $f2 ]; then
    ic_2=""
elif [ $f3 ]; then
    ic_3=""
elif [ $f4 ]; then
    ic_4=""
elif [ $f5 ]; then
    ic_5=""
elif [ $f6 ]; then
    ic_6=""
elif [ $f7 ]; then
    ic_7=""
elif [ $f8 ]; then
    ic_8=""
elif [ $f9 ]; then
    ic_9=""
elif [ $f10 ]; then
    ic_10=""
fi

echo "$ic_1 $ic_2 $ic_3 $ic_4 $ic_5 $ic_6 $ic_7 $ic_8 $ic_9 $ic_10"
