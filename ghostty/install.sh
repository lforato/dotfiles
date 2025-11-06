#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/ghostty"

mkdir -p "$CONFIG_DIR"

ln -sf "$(pwd)/config" "$CONFIG_DIR/config"

cp -r "$(pwd)/themes" "$CONFIG_DIR/themes"

echo "✅ Ghostty configuration installed successfully"
