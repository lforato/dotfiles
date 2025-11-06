#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/ghostty"
GHOSTTY_DIR="$(pwd)/../ghostty"

mkdir -p "$CONFIG_DIR"

ln -sf "$GHOSTTY_DIR/config" "$CONFIG_DIR/config"

cp -r "$GHOSTTY_DIR/themes" "$CONFIG_DIR/themes"

echo "✅ Ghostty configuration installed successfully"
