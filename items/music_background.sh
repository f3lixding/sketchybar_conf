#!/bin/bash

# Add a background bracket for all left side items
sketchybar --add bracket music_background \
  music-artwork \
  music \
  --set music_background \
    background.color="$ITEM_BG_COLOR" \
    background.corner_radius=8 \
    background.height=32 \
    background.padding_left=4 \
    background.padding_right=4 \
