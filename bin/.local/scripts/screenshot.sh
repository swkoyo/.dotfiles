#!/bin/bash
FILE=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
mkdir -p ~/Pictures/Screenshots

hyprctl keyword animation "fadeOut,0,0,default"
grimblast copysave area "$FILE"
hyprctl keyword animation "fadeOut,1,4,default"

action=$(notify-send "Screenshot saved" "$FILE" \
    --icon="$FILE" \
    --action="default=Open folder" \
    --wait \
    --print-id 2>/dev/null)

if [ -n "$action" ]; then
    thunar ~/Pictures/Screenshots
fi
