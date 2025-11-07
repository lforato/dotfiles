#!/usr/bin/env bash

CONFIG_DIR="$HOME/.config/zsh"
ZSH_DIR="$(pwd)/../zsh"

mkdir -p "$HOME/.config"
mkdir -p "$CONFIG_DIR"

ln -sf "$ZSH_DIR/.zshrc" "$CONFIG_DIR/.zshrc"

ln -sf "$ZSH_DIR/alias.sh" "$CONFIG_DIR/alias.sh"

ln -sf "$ZSH_DIR/starship.toml" "$HOME/.config/starship.toml"

echo "✅ zsh configuration installed successfully"

