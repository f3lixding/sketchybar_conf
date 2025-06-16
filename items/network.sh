#!/bin/bash

sketchybar -m --add item network right \
  --subscribe network wifi_change \
  --set network drawing=on \
                script="$PLUGIN_DIR/wifi.sh"
