#!/usr/bin/env bash
# setup.sh — symlink the zellij config from this repo into ~/.config/zellij
#
# Idempotent: safe to re-run. Existing files are left alone unless --force.
# Usage:
#   ./setup.sh           dry-run  (shows what would happen)
#   ./setup.sh --apply   create symlinks
#   ./setup.sh --force   overwrite existing symlinks/files

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.config/zellij"
BIN="$HOME/bin"

DRY=true
FORCE=false
for arg in "$@"; do
    [[ "$arg" == "--apply" ]] && DRY=false
    [[ "$arg" == "--force" ]] && FORCE=true DRY=false
done

link() {
    local src="$1" dst="$2"
    if [[ "$DRY" == true ]]; then
        echo "[dry-run] ln -sf $src $dst"
        return
    fi
    if [[ -e "$dst" && "$FORCE" == false ]]; then
        echo "skip (exists): $dst"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "linked: $dst -> $src"
}

echo "=== Zellij config setup (repo: $REPO_DIR) ==="

link "$REPO_DIR/config.kdl"                   "$TARGET/config.kdl"
link "$REPO_DIR/layouts/project.kdl"          "$TARGET/layouts/project.kdl"
link "$REPO_DIR/layouts/launcher.kdl"         "$TARGET/layouts/launcher.kdl"
link "$REPO_DIR/scripts/zj.sh"               "$TARGET/scripts/zj.sh"
link "$REPO_DIR/scripts/switch-session.sh"   "$TARGET/scripts/switch-session.sh"
link "$REPO_DIR/scripts/help.sh"             "$TARGET/scripts/help.sh"

# zj shortcut in ~/bin
mkdir -p "$BIN"
link "$REPO_DIR/scripts/zj.sh" "$BIN/zj"

if [[ "$DRY" == true ]]; then
    echo ""
    echo "Run with --apply to create symlinks."
fi

echo ""
echo "Make scripts executable:"
[[ "$DRY" == false ]] && chmod +x "$REPO_DIR/scripts/"*.sh "$REPO_DIR/setup.sh"
echo "  chmod +x $REPO_DIR/scripts/*.sh $REPO_DIR/setup.sh"

echo ""
echo "Ensure ~/bin is in PATH:"
echo "  export PATH=\"\$HOME/bin:\$PATH\"  # add to ~/.bashrc or ~/.zshrc"
