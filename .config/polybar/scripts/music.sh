#!/bin/bash

mpd=$(mpc current 2>/dev/null)

if [ -n "$mpd" ]; then
    echo "  $mpd"
else
    mpris=$(playerctl metadata --format "{{artist}} - {{title}}" 2>/dev/null)
    if [ -n "$mpris" ]; then
        echo "  $mpris"
    else
        echo ""
    fi
fi
