#!/usr/bin/env bash
printf '\e[35;1m\n'
cat << 'EOF'
╔══════════════════════════════════════════════════╗
║   WezTerm  ·  LEADER = ALT+Z  (1.5 s)           ║
╠══════════════════════════════════════════════════╣
║  WORKSPACES                                      ║
║  LEADER w          fuzzy workspace picker        ║
║  LEADER 1–7        jump to workspace directly    ║
║  LEADER [ / ]      cycle prev / next             ║
╠══════════════════════════════════════════════════╣
║  TABS                                            ║
║  CTRL+ALT 1–4      jump to tab                  ║
║  CTRL+SHIFT H / L  prev / next tab               ║
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
║  LEADER n          task-complete toast           ║
╠══════════════════════════════════════════════════╣
║  UTILITY                                         ║
║  LEADER ?          full key legend overlay       ║
║  LEADER c          copy mode (vi scroll)         ║
║  CTRL+SHIFT F      fullscreen                    ║
║  CTRL  + / - / 0   font size inc / dec / reset   ║
╚══════════════════════════════════════════════════╝
EOF
printf '\e[0m\n'
exec bash -l
