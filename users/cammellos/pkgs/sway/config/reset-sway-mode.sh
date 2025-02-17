#!/usr/bin/env bash

switch_mode() {
  case "$1" in
    "ferdium")
      swaymsg mode "ferdium"
      ;;
    "librewolf")
      swaymsg mode "librewolf"
      ;;
    "kitty")
      container_name=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .name')
      if [[ "$container_name" == *"nvim"* ]]; then
        swaymsg mode "nvim"
      else
        swaymsg mode "kitty"
      fi
      ;;
    *)
      swaymsg mode "default"
      ;;
  esac
}

# Monitor window focus changes and switch modes
while true; do
  swaymsg -t subscribe '[ "window" ]' | jq -r 'select(.change == "focus")' | jq -r '.container.app_id' | while read -r app_id; do
    switch_mode "$app_id"
  done
done
