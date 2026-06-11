#!/usr/bin/env bash
# Install Node 20 LTS via nvm and Claude Code CLI inside WSL2
set -e

echo "==> Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Load nvm without restarting shell
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "==> Installing Node 20 LTS..."
nvm install 20
nvm use 20
nvm alias default 20

echo "Node: $(node --version)"
echo "npm:  $(npm --version)"

echo "==> Installing Claude Code..."
npm install -g @anthropic-ai/claude-code

echo ""
echo "Claude: $(claude --version)"
echo ""
echo "Done. Restart your shell or run: source ~/.bashrc"
