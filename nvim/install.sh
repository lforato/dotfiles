#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$CONFIG_DIR"
ln -sf "$(pwd)/config" "$CONFIG_DIR/init.lua"

echo "✅ Linked $(pwd)/config → $CONFIG_DIR/init.lua"
