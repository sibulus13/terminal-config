# Dotfiles — Open Projects

## [TERMINAL] Zellij — Persistent Context Panel

**Status:** Config files written, awaiting WSL2 setup
**Goal:** Per-workspace always-visible panel showing goals, tasks, and progress.
WezTerm stays as the OS window and GPU renderer; Zellij runs inside it as the multiplexer.

### Setup steps (in order)
1. **Install WSL2** — run in admin PowerShell, then restart:
   ```powershell
   wsl --install
   ```
2. **Install Zellij config** — run from inside WSL2:
   ```bash
   bash /mnt/c/Users/Michael/dotfiles/zellij/install-wsl.sh
   ```
3. **Create a workspace context file** — once per project:
   ```bash
   cd /path/to/project && bash ~/dotfiles/zellij/init-context.sh
   ```
4. **Launch Zellij** — default layout (context sidebar + terminal):
   ```bash
   zellij
   ```
   Agent layout (context + vsplit panes):
   ```bash
   zellij --layout agent
   ```

### Config files
| File | Purpose |
|------|---------|
| `zellij/config.kdl` | Theme, keybindings (ALT+[ / ALT+] etc.), options |
| `zellij/layouts/workspace.kdl` | Default: context sidebar + main terminal |
| `zellij/layouts/agent.kdl` | Agent work: context + vsplit panes |
| `zellij/init-context.sh` | Scaffold `~/contexts/<project>.md` for a new project |
| `zellij/install-wsl.sh` | Symlinks config, installs Zellij binary |

### Context panel
- Lives at `~/contexts/<basename of cwd>.md`
- Updates every 3s (via `watch -n 3`)
- Edit directly in any editor — changes appear in the sidebar immediately
- Template created by `init-context.sh`: Goal / In Progress / Up Next / Done / Notes

### Keybindings (Zellij — matches WezTerm muscle memory)
| Key | Action |
|-----|--------|
| `ALT+[` / `ALT+]` | Prev / next tab |
| `ALT+1–7` | Jump to tab |
| `ALT+h/j/k/l` | Move between panes |
| `ALT+\|` / `ALT+-` | Split pane right / down |
| `ALT+z` | Zoom / unzoom active pane |
| `ALT+c` | Focus context sidebar |
| `ALT+d` | Detach Zellij session |

---

## [THEME] Crimson Noir — Custom WezTerm Theme

**Status:** In progress (base palette applied, needs refinement)
**Goal:** A fully hand-crafted WezTerm color scheme with a dark-mysterious-premium aesthetic.

### Vision
- Background: deep purple-black void (`#0e0014`)
- Primary accent: very saturated crimson-magenta (`#c4185c`)
- Secondary: regal deep purple (`#8b1aaa`)
- Feel: dark, mysterious, premium — not neon, not pastel

### Current state
Base palette is live in `wezterm/wezterm.lua` under `config.colors`.
All 16 ANSI slots assigned. Tab bar overrides in place.

### Remaining work
- [ ] Live-tune accent saturation/brightness after extended use
- [ ] Build a standalone `.toml` file so the scheme is portable / shareable
- [ ] Verify contrast ratios across all 16 ANSI pairs (WCAG AA minimum 4.5:1)
- [ ] Design palette using oklch.com for perceptual uniformity
- [ ] Consider publishing to the WezTerm color scheme gallery

### Tools
- Palette design: https://coolors.co  /  https://oklch.com
- Contrast check: https://webaim.org/resources/contrastchecker
- ANSI slot reference: slots 1=red 2=green 3=yellow 4=blue 5=magenta 6=cyan

### How to extract into a portable .toml
```toml
# ~/.config/wezterm/colors/crimson-noir.toml
[colors]
background = "#0e0014"
foreground = "#edd9f5"
# ... rest of palette

[colors.tab_bar]
# ... tab bar overrides
```
Then in wezterm.lua: `config.color_scheme = "crimson-noir"`
(WezTerm auto-discovers .toml files in the colors/ subdirectory)
