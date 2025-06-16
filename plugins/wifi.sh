#!/bin/bash
SSID=$(ipconfig getsummary $(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}') | awk -F ' SSID : ' '/ SSID : / {print $2}')

if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" \
    icon=󰖪 \
    drawing=on
else 
  sketchybar --set "$NAME" \
    icon=󰖩 \
    drawing=on
fi
