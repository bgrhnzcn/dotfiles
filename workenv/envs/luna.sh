#!/usr/bin/env bash

# Configuration
SESSION_NAME="luna"
WORK_DIR="$HOME/work/luna"
EXTRA_PATH="$HOME/work/luna/bin"  # You can change this

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Attaching to existing tmux session '$SESSION_NAME'..."
    tmux attach -t "$SESSION_NAME"
    exit 0
fi

# Create a new tmux session in detached mode
tmux new-session -d -s "$SESSION_NAME" -c "$WORK_DIR" \
    "export PATH=\"$EXTRA_PATH:\$PATH\"; exec bash"

# Attach to the new session
tmux attach -t "$SESSION_NAME"

