#!/usr/bin/env bash

killall -q polybar

while pgrep -x polybar >/dev/null; do
  sleep 1
done

EXTERNAL=$(xrandr | awk '/ connected/ && $1 != "LVDS-1" {print $1; exit}')

if [ -n "$EXTERNAL" ]; then
  MONITOR="$EXTERNAL" polybar main &
else
  MONITOR=LVDS-1 polybar main &
fi
