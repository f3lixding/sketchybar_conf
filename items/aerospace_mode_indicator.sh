#!/bin/bash

sketchybar --add item aerospace_mode left \
  --subscribe aerospace_mode aerospace_mode_change \
  --set aerospace_mode \
  padding_left=10 \
  script="$CONFIG_DIR/plugins/aerospace_mode.sh" \
  icon.color="$ACCENT_COLOR" \
  icon.padding_left=4 \
  drawing=off

