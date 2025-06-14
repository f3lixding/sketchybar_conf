#!/bin/bash

# Get network interface (usually en0 for WiFi)
INTERFACE=$(route get default | grep interface | awk '{print $2}')

# Function to get network stats
get_network_stats() {
    netstat -ibn | grep -E "^$INTERFACE" | head -1 | awk '{print $7" "$10}'
}

# Get current stats
CURRENT_STATS=$(get_network_stats)
CURRENT_RX=$(echo $CURRENT_STATS | awk '{print $1}')
CURRENT_TX=$(echo $CURRENT_STATS | awk '{print $2}')

# Read previous stats from temp file
TEMP_FILE="/tmp/sketchybar_network_stats"
if [[ -f "$TEMP_FILE" ]]; then
    PREV_STATS=$(cat "$TEMP_FILE")
    PREV_RX=$(echo $PREV_STATS | awk '{print $1}')
    PREV_TX=$(echo $PREV_STATS | awk '{print $2}')
    PREV_TIME=$(echo $PREV_STATS | awk '{print $3}')
else
    PREV_RX=0
    PREV_TX=0
    PREV_TIME=$(date +%s)
fi

# Calculate time difference
CURRENT_TIME=$(date +%s)
TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

if [[ $TIME_DIFF -gt 0 ]]; then
    # Calculate speeds in bytes per second
    RX_SPEED=$(((CURRENT_RX - PREV_RX) / TIME_DIFF))
    TX_SPEED=$(((CURRENT_TX - PREV_TX) / TIME_DIFF))
    
    # Convert to human readable format
    format_speed() {
        local speed=$1
        if [[ $speed -gt 1048576 ]]; then
            echo "$(echo "scale=1; $speed / 1048576" | bc)MB/s"
        elif [[ $speed -gt 1024 ]]; then
            echo "$(echo "scale=1; $speed / 1024" | bc)KB/s"
        else
            echo "${speed}B/s"
        fi
    }
    
    DOWN_SPEED=$(format_speed $RX_SPEED)
    UP_SPEED=$(format_speed $TX_SPEED)
    
else
    UP_SPEED="0B/s"
    DOWN_SPEED="0B/s"
fi

# Save current stats for next run
echo "$CURRENT_RX $CURRENT_TX $CURRENT_TIME" > "$TEMP_FILE"

# Update sketchybar with compact format
LABEL="↑$UP_SPEED ↓$DOWN_SPEED"
sketchybar --set "$NAME" label="$LABEL"