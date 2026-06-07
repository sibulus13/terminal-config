#!/usr/bin/env bash
printf '\e[35;1m\n'
cat << 'EOF'
╔══════════════════════════════════════════════════╗
║   WezTerm  ·  LEADER = ALT+Z  (1.5 s)           ║
╠══════════════════════════════════════════════════╣
║  WORKSPACES                                      ║
║  ALT + 0           launcher / help               ║
║  ALT + 1–7         open / switch workspace       ║
║  ALT + ← / →       cycle prev / next workspace   ║
║  ALT+Z  w          fuzzy picker (by name)        ║
╠══════════════════════════════════════════════════╣
║  TABS                                            ║
║  CTRL+Tab          next tab                      ║
║  CTRL+SHIFT+Tab    prev tab                      ║
║  CTRL+ALT 1–4      jump to tab by number         ║
║  CTRL+SHIFT T      new tab (same dir)            ║
║  CTRL+SHIFT W      close tab                     ║
╠══════════════════════════════════════════════════╣
║  PANES                                           ║
║  LEADER |          split right                   ║
║  LEADER -          split down                    ║
║  LEADER h/j/k/l    move between panes            ║
║  LEADER z          zoom / unzoom pane            ║
╠══════════════════════════════════════════════════╣
║  MACROS                                          ║
║  LEADER r          registry regen                ║
║  LEADER b          backtest broad sweep          ║
║  LEADER d          pnpm dev                      ║
║  ALT+Z  N          new workspace wizard          ║
║  ALT+Z  T          task-complete toast           ║
╠══════════════════════════════════════════════════╣
║  UTILITY                                         ║
║  ALT+Z  H          full key legend overlay       ║
║  LEADER c          copy mode (vi scroll)         ║
║  CTRL+SHIFT F      fullscreen                    ║
║  CTRL  + / - / 0   font size inc / dec / reset   ║
╚══════════════════════════════════════════════════╝
EOF
printf '\e[0m\n'
exec bash -l
