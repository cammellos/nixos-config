#!/usr/bin/env bash

# Check if the focused window is a Kitty instance
FOCUSED_KITTY_PID=$(swaymsg -t get_tree | jq -r '
    .. | select(.app_id? == "kitty") | select(.focused == true) | .pid
')

if [ "$FOCUSED_KITTY_PID" ]; then
  kitten @ --to unix:"/tmp/kitty_${FOCUSED_KITTY_PID}" action kitty_scrollback_nvim
fi
