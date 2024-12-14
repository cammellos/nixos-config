#!/usr/bin/env bash

# Check if the parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <parameter>"
  exit 1
fi

# Get the focused window's app_id (class name)
PID=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .pid')

# Find the first non-empty pts for the given PID
PTS=$(ps -ef | grep "$PID" | grep -v "grep" | awk '$6 != "?" {print $6}' | head -n 1)

# Check if a pts was found
if [ -z "$PTS" ]; then
  echo "No pts found for PID $PID"
  exit 1
fi

# Run tmux list-sessions and find the matching session
SESSION=$(tmux list-sessions | grep "$PTS" | awk '{print $1}' | sed 's/:$//')

# Check if the session was found
if [ -z "$SESSION" ]; then
  echo "No tmux session found for pts $PTS"
  exit 1
fi

# Call tmux-window-handler.sh with the parameter and session
tmux-window-handler.sh "$1" "$SESSION"
