#!/usr/bin/env bash

SESSION_NAME="music_player"
SCRIPT_PATH="$HOME/.config/ncmpcpp/npm_listener.sh"


if tmux has-session -t $SESSION_NAME 2>/dev/null; then
  echo "Session $SESSION_NAME already exists. Attaching to it"
  tmux attach-session -t $SESSION_NAME
else
  # tmux new-session -d -s $SESSION_NAME
  tmux new-session -d -s "$SESSION_NAME" "$SCRIPT_PATH"

  tmux split-window -v
  tmux split-window -h -t 0
  sleep 1

  # tmux send-keys -t 0 "bash $HOME/.config/ncmpcpp/npm_listener.sh" C-m
  tmux send-keys -t o 'echo aaaa' C-m

  tmux send-keys -t 1 'echo "Hello from pane 2"' C-m

  tmux attach-session -t $SESSION_NAME
fi
