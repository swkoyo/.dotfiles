#!/usr/bin/env bash

# $1 is the workspace ID (e.g., 1, 2, etc.)
# $NAME is the SketchyBar item name (e.g., space.1)
# $FOCUSED_WORKSPACE is the current focused workspace
# $PREV_WORKSPACE is the previous workspace

# Highlight the focused workspace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" background.drawing=on background.color=0xff89b4fa label.color=0xff1e1e2e
else
    sketchybar --set "$NAME" background.drawing=off background.color=0x44ffffff label.color=0xffffffff
fi

# Check if the previous workspace is empty and remove it
if [ -n "$PREV_WORKSPACE" ] && [ "$PREV_WORKSPACE" != "$FOCUSED_WORKSPACE" ]; then
    ACTIVE_WORKSPACES=$(aerospace list-windows --all --format '%{workspace}' | sort -u)
    if ! echo "$ACTIVE_WORKSPACES" | grep -Fx "$PREV_WORKSPACE" > /dev/null; then
        sketchybar --remove "space.$PREV_WORKSPACE"
    fi
fi
