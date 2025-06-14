#!/bin/bash

# Open app on middle click
if [ "$BUTTON" = "other" ]; then
  open -a 'Spotify'
  exit 0
fi

# Toggle play/pause on left click
if [ "$BUTTON" = "left" ]; then
  osascript -e 'tell application "Spotify" to playpause'
fi

# Skip to next song on right click
if [ "$BUTTON" = "right" ]; then
  osascript -e 'tell application "Spotify" to next track'
fi

# Get current track info from Spotify
SPOTIFY_STATE=$(osascript -e 'tell application "Spotify" to player state as string')
CURRENT_SONG=$(osascript -e 'tell application "Spotify" to name of current track & " - " & artist of current track')
ARTWORK=$(osascript -e 'tell application "Spotify" to artwork url of current track')

if [ "$SPOTIFY_STATE" = "paused" ]; then
  ICON=􀊄
else
  ICON=􁁒
fi

# Download artwork if available
if [ -n "$ARTWORK" ] && [ "$ARTWORK" != "missing value" ]; then
  ARTWORK_LOCATION="$(curl -O --output-dir "$TMPDIR" -s --remote-name -w "%{filename_effective}" "$ARTWORK")"
  sketchybar --set "$NAME"-artwork background.image="$ARTWORK_LOCATION"
fi

sketchybar --set "$NAME" label="$CURRENT_SONG" icon="$ICON" drawing=on