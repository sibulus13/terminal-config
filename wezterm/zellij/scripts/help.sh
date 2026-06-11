#!/usr/bin/env bash
# Zellij quick-reference panel — redraws automatically when this file is saved.

SELF="${BASH_SOURCE[0]}"

show_help() {
  clear
  printf '\e[35;1m'
  cat << 'EOF'

  Zellij  ·  LEADER = ALT+Z  ·  ALT+P for session picker

  SESSIONS                              TABS  (LEADER)
  ───────────────────────────────────   ──────────────────────────
  ALT + P          session picker       LEADER + N   new tab
  ALT+SHIFT + ← →  cycle sessions       LEADER + W   close tab
  zj               launch / attach
  zj <name>        named session        (cycle tabs via ALT pane
                                         nav — edge wraps to tab)

  PANES  (ALT arrows — most frequent; wraps to adjacent tab at edge)
  ──────────────────────────────────────────────────────────────────
  ALT + ← → ↑ ↓    navigate panes  (wraps to next/prev tab at edge)
  LEADER + \        split right
  LEADER + -        split down
  LEADER + Z        zoom / unzoom pane
  LEADER + C        scroll / copy mode  (vi keys: j/k  Ctrl-d/u/f/b)

  UTILITY
  ──────────────────────────────────────────────────────────────────
  CTRL+SHIFT + C/V  copy / paste
  CTRL+SHIFT + F    fullscreen

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
