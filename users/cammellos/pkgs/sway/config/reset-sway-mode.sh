#!/usr/bin/env bash

switch_mode() {
  case "$1" in
    "ferdium")
      echo "ENTERING FERDIUM"
      swaymsg mode "ferdium"
      ;;
    "firefox")
      echo "ENTERING FIREFOX"
      swaymsg mode "librewolf"
      ;;
    "kitty")
      container_name=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .name')
      echo "CONTAINER NAME: $container_name"
      if [[ "$container_name" == *"nvim"* ]]; then
	echo "ENTERING nvim"
        swaymsg mode "nvim"
      else
	echo "ENTERING kitty"
        swaymsg mode "kitty"
      fi
      ;;
    *)
      echo "ENTERING DEFAULT"
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
