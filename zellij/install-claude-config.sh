#!/usr/bin/env bash
# Link WSL2 Claude Code config to the Windows installation.
# Run once after setting up WSL2. Safe to re-run.
#
# What gets symlinked (bidirectional — edit on either side, both see it):
#   CLAUDE.md      global instructions + orchestration rules
#   skills/        custom slash commands (/orchestrate, /retrospect, etc.)
#   settings.json  permissions, hooks, plugins
#
# What stays separate:
#   projects/           project keys encode OS paths (different on Win vs WSL2)
#   settings.local.json machine-local overrides
#   .credentials.json   platform auth tokens
#   cache/ sessions/    runtime state

set -e

WIN_CLAUDE="/mnt/c/Users/Michael/.claude"
WSL_CLAUDE="$HOME/.claude"

if [[ ! -d "$WIN_CLAUDE" ]]; then
  echo "ERROR: Windows .claude not found at $WIN_CLAUDE"
  exit 1
fi

mkdir -p "$WSL_CLAUDE"

link() {
  local name="$1"
  local target="$WIN_CLAUDE/$name"
  local link="$WSL_CLAUDE/$name"

  if [[ ! -e "$target" ]]; then
    echo "SKIP $name (not found in Windows install)"
    return
  fi

  if [[ -L "$link" ]]; then
    echo "already linked: $link"
    return
  fi

  if [[ -e "$link" ]]; then
    echo "backing up: $link -> $link.bak"
    mv "$link" "$link.bak"
  fi

  ln -sfn "$target" "$link"
  echo "linked: $link -> $target"
}

link "CLAUDE.md"
link "skills"
link "settings.json"

echo ""
echo "Verify:"
ls -la "$WSL_CLAUDE/CLAUDE.md" "$WSL_CLAUDE/skills" "$WSL_CLAUDE/settings.json" 2>/dev/null
echo ""
echo "Done. Changes to CLAUDE.md or skills/ on either side are now instant."
