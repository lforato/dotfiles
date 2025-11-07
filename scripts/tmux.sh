#!/usr/bin/env bash

CONFIG_DIR="$HOME"
TMUX_DIR="$(pwd)/../tmux"

ln -sf "$TMUX_DIR/.tmux.conf" "$CONFIG_DIR/.tmux.conf"

echo "✅ tmux configuration installed successfully"
