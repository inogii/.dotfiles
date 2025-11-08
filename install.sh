#!/usr/bin/env bash
set -e

echo "Setting up dotfiles..."

ln -sf ~/.dotfiles/bashrc ~/.bashrc
ln -sf ~/.dotfiles/bash_profile ~/.bash_profile
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

echo "Done! Restart your shell or run: source ~/.bashrc"
