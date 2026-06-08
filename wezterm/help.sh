#!/usr/bin/env bash
printf '\e[35;1m\n'
cat << 'EOF'
╔══════════════════════════════════════════════════╗
║   WezTerm  ·  LEADER = ALT+Z  (1.5 s)           ║
╠══════════════════════════════════════════════════╣
║  WORKSPACES                                      ║
║  ALT + P           open / launch workspace       ║
║  ALT + ↑ / ↓       cycle workspaces              ║
║  ALT + 0           launcher / help               ║
╠══════════════════════════════════════════════════╣
║  TABS                                            ║
║  ALT + ← / →       prev / next tab               ║
║  CTRL+SHIFT T      new tab                       ║
║  CTRL+SHIFT W      close tab                     ║
╠══════════════════════════════════════════════════╣
║  PANES                                           ║
║  LEADER |          split right                   ║
║  LEADER -          split down                    ║
║  LEADER h/j/k/l    navigate panes                ║
║  LEADER z          zoom / unzoom pane            ║
╠══════════════════════════════════════════════════╣
║  UTILITY                                         ║
║  ALT + /           key legend overlay            ║
║  CTRL+SHIFT F      fullscreen                    ║
║  CTRL  + / - / 0   font size                     ║
╚══════════════════════════════════════════════════╝
EOF
printf '\e[0m'
read -rsp $'  \e[35m[Enter]\e[0m to open shell...\n' _
exec bash -l
