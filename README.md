# dotfiles

Personal terminal config — Michael Huang.

## Contents

| Dir | Tool | Notes |
|-----|------|-------|
| `wezterm/` | [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator config + project workspaces |

## Install (new machine)

```powershell
git clone https://github.com/sibulus13/terminal-config ~/dotfiles
cd ~/dotfiles
.\install.ps1
```

### Dependencies

- **Git for Windows** — provides `bash` at `C:\Program Files\Git\bin\bash.exe`
- **JetBrains Mono** font — https://www.jetbrains.com/lp/mono/
- **WezTerm** — https://wezfurlong.org/wezterm/

## WezTerm quick reference

| Keys | Action |
|------|--------|
| `LEADER` = `CTRL+SPACE` (1.5s window) | — |
| `LEADER w` | Fuzzy-pick project workspace |
| `LEADER 1–7` | Jump directly to workspace |
| `LEADER [` / `]` | Cycle workspaces prev/next |
| `CTRL+ALT 1–4` | Jump to tab in current workspace |
| `CTRL+SHIFT H/L` | Prev/next tab |
| `LEADER \|` / `-` | Split pane right / down |
| `LEADER h/j/k/l` | Move between panes |
| `LEADER z` | Zoom pane |
| `LEADER ?` | Show full key binding legend |

## Adding a new project workspace

Edit `wezterm/projects.lua` — duplicate any entry, set a unique `id`, update `cwd` and `tabs`.
WezTerm hot-reloads the config automatically.
