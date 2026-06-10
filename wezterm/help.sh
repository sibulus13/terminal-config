#!/usr/bin/env bash
# Live help panel — redraws automatically when this file is saved.
# The right pane is your shell; this pane stays as a reference.

SELF="${BASH_SOURCE[0]}"

show_help() {
  clear
  printf '\e[35;1m'
  cat << 'EOF'

  WezTerm  ·  LEADER = ALT+Z (1.5 s)  ·  ALT+/ for full legend
  Layout: agent (single pane)  ·  shell (vsplit — two plain shells)

  WORKSPACES                            TABS  (LEADER)
  ───────────────────────────────────   ──────────────────────────
  ALT + P          open / switch        LEADER + N   new tab
  ALT + N          new  (prompt path)   LEADER + W   close tab
  ALT + W          close workspace
  ALT + 0          launcher / help      (cycle tabs via ALT pane
  ALT+SHIFT + ← →  cycle workspaces      nav — edge wraps to tab)

  PANES  (ALT arrows — most frequent; wraps to adjacent tab at edge)
  ──────────────────────────────────────────────────────────────────
  ALT + ← → ↑ ↓    navigate panes  (wraps to next/prev tab at edge)
  LEADER + \        split right  (tracked for undo)
  LEADER + -        split down   (tracked for undo)
  LEADER + U        undo last split
  LEADER + Z        zoom / unzoom pane
  LEADER + C        copy mode  (vi scroll + select)
  LEADER + S        save layout  (◆ updates status bar)

  UTILITY
  ──────────────────────────────────────────────────────────────────
  ALT + /           full key legend overlay  (searchable, runnable)
  CTRL+SHIFT + C/V  copy / paste
  CTRL+SHIFT + F    fullscreen
  CTRL + = / - / 0  font size  (increase / decrease / reset)

EOF
  printf '\e[0m'
}

last_mod=$(stat -c '%Y' "$SELF" 2>/dev/null)
show_help

while true; do
  sleep 1
  cur_mod=$(stat -c '%Y' "$SELF" 2>/dev/null)
  if [[ "$cur_mod" != "$last_mod" ]]; then
    last_mod="$cur_mod"
    show_help
  fi
done
