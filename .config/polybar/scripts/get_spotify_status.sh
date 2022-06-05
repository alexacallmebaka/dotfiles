#!/bin/bash

#I heavily modded an existing script to create this one. You can find the original here: https://github.com/PrayagS/polybar-spotify.

PLAYER="spotifyd"

FORMAT="%{F#1ED760} %{F#FFFFFF} {{ title }}%{F#1ED760} ﴁ %{F#FFFFFF}{{ artist }}"

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "%{F#1ED760}  %{F#FFFFFF}Music Stopped"
    elif [ "$STATUS" = "Paused"  ]; then
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    elif [ "$STATUS" = "No player is running"  ]; then
        echo "%{F#1ED760}  %{F#FF0000}ﱙ "
    else
        playerctl --player=$PLAYER metadata --format "$FORMAT"
    fi
fi
