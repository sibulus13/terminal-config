#!/usr/bin/env bash
# switch-session.sh — cycle Zellij sessions prev/next (for ALT+SHIFT+←/→)
#
# Usage: switch-session.sh prev | next

direction="${1:-next}"

sessions=$(zellij list-sessions --no-formatting 2>/dev/null | awk '{print $1}' | sort)
[[ -z "$sessions" ]] && exit 0

current=$(zellij list-sessions --no-formatting 2>/dev/null \
    | grep '\[current\]' | awk '{print $1}')
[[ -z "$current" ]] && exit 0

mapfile -t names <<< "$sessions"
count=${#names[@]}

# find current index
idx=-1
for i in "${!names[@]}"; do
    [[ "${names[$i]}" == "$current" ]] && idx=$i && break
done
[[ $idx -eq -1 ]] && exit 0

if [[ "$direction" == "next" ]]; then
    target=$(( (idx + 1) % count ))
else
    target=$(( (idx - 1 + count) % count ))
fi

zellij action switch-session "${names[$target]}"
