#!/bin/bash

CURRENT_MODE=$(aerospace list-modes --current)

if [ "$CURRENT_MODE" == "main" ]; then
  sketchybar --set "$NAME" \
    drawing=off
elif [ "$CURRENT_MODE" == "jump" ]; then
  sketchybar --set "$NAME" \
    icon="⇄" \
    drawing=on
elif [ "$CURRENT_MODE" == "move" ]; then
  sketchybar --set "$NAME" \
    icon="●" \
    drawing=on
elif [ "$CURRENT_MODE" == "service" ]; then
  sketchybar --set "$NAME" \
    icon="" \
    drawing=on
fi
