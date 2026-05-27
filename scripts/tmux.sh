#!/usr/bin/env bash

TMUX_DIR="$(pwd)/../tmux"

ln -sf "$TMUX_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "✅ tmux configuration installed successfully"
