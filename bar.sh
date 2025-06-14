#!/bin/bash

bar=(
  position=top
  height=38
  y_offset=2
  corner_radius=0
  color="$TRANSPARENT"
  margin=-10
)

sketchybar --bar "${bar[@]}"
