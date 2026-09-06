#!/bin/bash

layout=$(hyprctl devices -j | jq -r '
    .keyboards[]
    | select(.main == true)
    | .active_keymap
')

case "$layout" in
    *"Portuguese"*|*"Brazil"*|*"br"*)
        echo "ABNT2"
        ;;
    *)
        echo "US"
        ;;
esac
