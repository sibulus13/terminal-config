#!/usr/bin/env bash
# zj — create or attach to a named Zellij session
#
# Usage:
#   zj                   fuzzy-pick from existing sessions + project registry
#   zj <name>            attach to <name> (creates it if it doesn't exist)
#   zj <name> <path>     create session rooted at <path>
#
# Project registry maps short names to absolute paths.
# Override REPO to point at your terminal-config clone.
# The ZELLIJ_CONFIG_DIR env var tells Zellij where to find config.kdl.

REPO="${REPO:-$HOME/repos/terminal-config}"
export ZELLIJ_CONFIG_DIR="$REPO/zellij"

# ── Project registry ─────────────────────────────────────────────────────────
# Add entries as: [name]="absolute/path"
declare -A PROJECTS=(
    [wezterm]="$HOME/repos/terminal-config"
    [stock-research]="$HOME/repos/stock-research"
    [cashcow]="$HOME/repos/cashcow"
    [sunset]="$HOME/repos/sunset"
    [tarive]="$HOME/repos/tarive"
    [europe]="$HOME/repos/europe"
    [life]="$HOME/repos/life"
    [si8]="$HOME/repos/si8"
    [vibesort]="$HOME/repos/vibesort"
)

# ── Helpers ───────────────────────────────────────────────────────────────────
_list_sessions() {
    zellij list-sessions --no-formatting 2>/dev/null | awk '{print $1}'
}

_pick() {
    local sessions running_names all_names
    sessions=$(_list_sessions)
    running_names=$(echo "$sessions" | grep -v '^$')

    # merge running sessions + registry, deduplicated, running ones first
    all_names=$(
        { echo "$running_names"; printf '%s\n' "${!PROJECTS[@]}"; } \
            | awk '!seen[$0]++'
    )

    echo "$all_names" | fzf \
        --prompt="session> " \
        --height=40% \
        --border \
        --preview="zellij list-sessions --no-formatting 2>/dev/null | grep -F '{}' || echo '(not running)'"
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
    local name="$1"
    local path="$2"

    # already inside Zellij — switch session instead of nesting
    if [[ -n "$ZELLIJ" ]]; then
        if [[ -z "$name" ]]; then
            name=$(_pick) || return 0
        fi
        zellij action switch-session "$name"
        return
    fi

    # pick interactively if no name given
    if [[ -z "$name" ]]; then
        name=$(_pick) || return 0
    fi

    # resolve path: explicit arg > registry > cwd
    if [[ -z "$path" ]]; then
        path="${PROJECTS[$name]:-$(pwd)}"
    fi

    # create or attach
    if _list_sessions | grep -qxF "$name"; then
        zellij attach "$name"
    else
        cd "$path" || { echo "zj: path not found: $path" >&2; return 1; }
        zellij --session "$name" --layout project
    fi
}

main "$@"
