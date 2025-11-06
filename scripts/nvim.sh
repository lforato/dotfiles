#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config"
NVIM_DIR="$(pwd)/.."

mkdir -p "$CONFIG_DIR"

ln -sf "$NVIM_DIR/nvim" "$CONFIG_DIR/nvim"

echo "✅ Neovim configuration installed successfully"
