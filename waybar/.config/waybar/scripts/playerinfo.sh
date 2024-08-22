#!/bin/sh

if playerctl metadata >/dev/null 2>&1; then
    song_info=$(playerctl metadata --format '{{ artist }} - {{ title }}')
else
    song_info="No Audio Playing"
fi

echo "$song_info"
