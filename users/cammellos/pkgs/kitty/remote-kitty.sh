#!/usr/bin/env bash

TAB_NUMBER=$1

# Check if the focused window is a Kitty instance
FOCUSED_KITTY_PID=$(swaymsg -t get_tree | jq -r '
    .. | select(.app_id? == "kitty") | select(.focused == true) | .pid
')

if [ -z "$FOCUSED_KITTY_PID" ]; then
  # Start Kitty if it's not already running in the current workspace
  exec kitty  -o allow_remote_control=yes --listen-on unix:/tmp/kitty_$$ --session launch.conf
else
  # Check if the Unix socket exists for the focused Kitty instance
  KITTY_SOCKET="/tmp/kitty_${FOCUSED_KITTY_PID}"
  if [ ! -S "$KITTY_SOCKET" ]; then
    exit 1
  fi
fi

# Check if the tab already exists
TAB_EXISTS=$(kitty @ --to unix:"/tmp/kitty_${FOCUSED_KITTY_PID}" ls | jq -e "
    .[] | .tabs[] | select(.title == \"$TAB_NUMBER\")
" > /dev/null 2>&1)

if [ $? -eq 0 ]; then
  # Tab exists, focus it
  kitten @ --to unix:"/tmp/kitty_${FOCUSED_KITTY_PID}" focus-tab --match title:^$TAB_NUMBER
else
  # Tab does not exist, create it
  kitten @ --to unix:"/tmp/kitty_${FOCUSED_KITTY_PID}" launch --type tab --title $TAB_NUMBER --cwd current
fi
