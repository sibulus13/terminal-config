#!/usr/bin/env bash
# Run this INSIDE WSL2 after cloning dotfiles.
# Symlinks Zellij config from the dotfiles repo into ~/.config/zellij.
# Usage: bash /mnt/c/Users/Michael/dotfiles/zellij/install-wsl.sh

set -e

DOTFILES_WIN="/mnt/c/Users/Michael/dotfiles"
ZELLIJ_CONFIG="$HOME/.config/zellij"

if [[ ! -d "$DOTFILES_WIN/zellij" ]]; then
  echo "ERROR: dotfiles not found at $DOTFILES_WIN"
  echo "Update DOTFILES_WIN in this script to match your Windows username."
  exit 1
fi

mkdir -p "$HOME/.config"

if [[ -d "$ZELLIJ_CONFIG" && ! -L "$ZELLIJ_CONFIG" ]]; then
  echo "Backing up existing ~/.config/zellij -> ~/.config/zellij.bak"
  mv "$ZELLIJ_CONFIG" "$ZELLIJ_CONFIG.bak"
fi

ln -sfn "$DOTFILES_WIN/zellij" "$ZELLIJ_CONFIG"
echo "Linked: $ZELLIJ_CONFIG -> $DOTFILES_WIN/zellij"

# Create contexts directory
mkdir -p "$HOME/contexts"
echo "Created: ~/contexts/  (per-workspace context files go here)"

# Install Zellij if not present
if ! command -v zellij &>/dev/null; then
  echo ""
  echo "Zellij not found. Installing latest release..."
  LATEST=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)
  curl -L "https://github.com/zellij-org/zellij/releases/download/${LATEST}/zellij-x86_64-unknown-linux-musl.tar.gz" \
    | tar xz
  sudo mv zellij /usr/local/bin/
  echo "Installed: $(zellij --version)"
else
  echo "Zellij already installed: $(zellij --version)"
fi

echo ""
echo "Done. Start Zellij with: zellij"
echo "Or for the agent layout:  zellij --layout agent"
