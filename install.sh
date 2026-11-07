#!/usr/bin/env bash
# Bootstrap a machine: packages, Starship, zsh plugins, config symlinks.
# Safe to re-run. Usage: ./install.sh [--dry-run] [--no-packages] [--chsh]
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
DRY=0; PACKAGES=1; CHSH=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    --no-packages) PACKAGES=0 ;;
    --chsh) CHSH=1 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

say() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
run() { if [ "$DRY" = 1 ]; then echo "    [dry-run] $*"; else "$@"; fi; }

case "$(uname -s)" in
  Darwin) OS=mac ;;
  Linux)  OS=linux ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac
say "Dotfiles: $DOTFILES ($OS)"

# --- Packages ---
if [ "$PACKAGES" = 1 ]; then
  if [ "$OS" = mac ]; then
    if ! command -v brew >/dev/null 2>&1; then
      echo "Homebrew not found. Install it from https://brew.sh and re-run." >&2; exit 1
    fi
    say "Installing Brewfile packages"
    run brew bundle --file="$DOTFILES/Brewfile"
  else
    say "Installing apt packages"
    run sudo apt-get update
    run sudo apt-get install -y $(grep -vE '^\s*(#|$)' "$DOTFILES/packages-apt.txt")
    if ! command -v starship >/dev/null 2>&1; then
      say "Installing Starship to ~/.local/bin"
      run mkdir -p "$HOME/.local/bin"
      if [ "$DRY" = 1 ]; then
        echo "    [dry-run] curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin"
      else
        curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
      fi
    fi
  fi
fi

# --- zsh plugins ---
say "Installing zsh plugins into $PLUGINS"
run mkdir -p "$PLUGINS"
for repo in zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting; do
  dir="$PLUGINS/$(basename "$repo")"
  if [ -d "$dir/.git" ]; then
    run git -C "$dir" pull --quiet --ff-only
  else
    run git clone --quiet --depth 1 "https://github.com/$repo" "$dir"
  fi
done

# --- Symlinks (existing real files are kept as .bak) ---
link() {
  local src="$1" dest="$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then return; fi
  run mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    run mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"
  fi
  run ln -s "$src" "$dest"
  echo "    linked $dest"
}
say "Linking config"
link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
link "$DOTFILES/bash/bashrc" "$HOME/.bashrc"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

# --- Untracked local file for secrets and machine-specific settings ---
if [ ! -f "$HOME/.zshrc.local" ]; then
  say "Creating ~/.zshrc.local (untracked: put API keys and machine-specific config here)"
  if [ "$DRY" = 0 ]; then
    printf '# Machine-specific config and secrets. Not tracked in git.\n' > "$HOME/.zshrc.local"
    chmod 600 "$HOME/.zshrc.local"
  fi
fi

# --- Default shell ---
if [ "$CHSH" = 1 ] && [ "$(basename "${SHELL:-}")" != zsh ]; then
  say "Setting zsh as the login shell"
  run chsh -s "$(command -v zsh)"
fi

say "Done. Open a new shell to see the changes."
