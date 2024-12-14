#!/usr/bin/env bash

# Exit if insufficient arguments are provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <window-id>" [<session-name>]
  exit 1
fi

# Default to the current tmux session name if no session is provided
SESSION_NAME="${2:-$(tmux display-message -p '#S')}"
WINDOW_ID="$1"

# Run the tmux command with the parameterized session and window ID
tmux if-shell "tmux list-windows -t ${SESSION_NAME} | grep -q \"^${WINDOW_ID}:\"" \
  "select-window -t ${SESSION_NAME}:${WINDOW_ID}" \
  "new-window -c \"#{session_path}\" -t ${SESSION_NAME}; if-shell \"tmux list-windows -t ${SESSION_NAME} | grep -q \\\"^${WINDOW_ID}:\\\"\" \"\" \"move-window -t ${SESSION_NAME}:${WINDOW_ID}\""
