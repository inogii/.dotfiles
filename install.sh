#!/usr/bin/env bash
set -e

echo "🔧 Setting up dotfiles..."

ln -sf ~/.dotfiles/bashrc ~/.bashrc

echo "✅ Dotfiles installed. Reload your shell or run: source ~/.bashrc"
