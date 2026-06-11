#!/usr/bin/env bash
# Install Zellij binary to ~/.local/bin (no sudo required)
set -e

BIN="$HOME/.local/bin"
mkdir -p "$BIN"

echo "Fetching latest Zellij release..."
LATEST=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
echo "Version: $LATEST"

echo "Downloading..."
curl -L "https://github.com/zellij-org/zellij/releases/download/${LATEST}/zellij-x86_64-unknown-linux-musl.tar.gz" -o /tmp/zellij.tar.gz

echo "Extracting..."
tar -xzf /tmp/zellij.tar.gz -C /tmp --no-same-owner 2>/dev/null || true

if [[ ! -f /tmp/zellij ]]; then
  echo "ERROR: extraction failed — binary not found at /tmp/zellij"
  exit 1
fi

mv /tmp/zellij "$BIN/zellij"
chmod +x "$BIN/zellij"
rm -f /tmp/zellij.tar.gz

echo "Installed: $($BIN/zellij --version)"
echo ""

# Ensure ~/.local/bin is in PATH via ~/.bashrc
if ! grep -q '\.local/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  echo "Added ~/.local/bin to PATH in ~/.bashrc"
fi

# Symlink Zellij config if not already done
ZELLIJ_CONFIG="$HOME/.config/zellij"
DOTFILES_WIN="/mnt/c/Users/Michael/dotfiles"

if [[ ! -L "$ZELLIJ_CONFIG" ]]; then
  mkdir -p "$HOME/.config"
  if [[ -d "$ZELLIJ_CONFIG" ]]; then
    echo "Backing up existing ~/.config/zellij -> ~/.config/zellij.bak"
    mv "$ZELLIJ_CONFIG" "$ZELLIJ_CONFIG.bak"
  fi
  ln -sfn "$DOTFILES_WIN/zellij" "$ZELLIJ_CONFIG"
  echo "Linked: $ZELLIJ_CONFIG -> $DOTFILES_WIN/zellij"
else
  echo "Config already linked: $ZELLIJ_CONFIG"
fi

# Create contexts directory
mkdir -p "$HOME/contexts"

echo ""
echo "Done. Launch Zellij with:"
echo "  zellij                   # default workspace layout"
echo "  zellij --layout agent    # context sidebar + vsplit panes"
