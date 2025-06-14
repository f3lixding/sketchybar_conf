#!/bin/bash

sketchybar --add item network_usage right \
  --set network_usage \
  icon=􀤆 \
  drawing=on \
  update_freq=5 \
  script="$PLUGIN_DIR/network_usage.sh"
