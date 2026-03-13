#!/bin/bash

MUSIC_DIR="$HOME/Music"
CACHE="/tmp/mpd_cover.jpg"

# get current music
file=$(mpc --format %file% current)
[ -z "$file" ] && exit

full="$MUSIC_DIR/$file"

# get cover
ffmpeg -loglevel quiet -y -i "$full" "$CACHE"

#  get terminal size (lines and cols)
TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)

# cal img size
# -2 to better align
IMG_HEIGHT=$((TERM_LINES - 2))
IMG_WIDTH=$((TERM_COLS - 2))

# clean last img
kitty +kitten icat --clear

# show img with some margin
kitty +kitten icat \
  --transfer-mode=memory \
  --place "${IMG_WIDTH}x${IMG_HEIGHT}@1x1" \
  "$CACHE"
