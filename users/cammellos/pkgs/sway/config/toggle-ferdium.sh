#!/usr/bin/env bash

# Check if the focused window has app_id "ferdium"
focused_app=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .app_id')

# If "ferdium" is focused, kill it directly
if [ "$focused_app" == "ferdium" ]; then
  swaymsg '[app_id="ferdium"] kill'
else
  # If "ferdium" is not focused or not open, close it and then run it
  swaymsg '[app_id="ferdium"] kill'
  # Launch Ferdium again
  ferdium &
fi
