# Terminal Config — Specification & Roadmap

## Vision

A single, always-open terminal instance that:
- Starts with **one OS window** and expands to any project on demand
- Is fully navigable from the **left hand only** (no mouse required)
- Shows **persistent workspace status** in the status bar
- Has a **legible key-legend** always accessible
- Remembers session state across restarts
- Looks premium: **Crimson Noir** dark theme with proper contrast

---

## Architecture

```
dotfiles/wezterm/
├── wezterm.lua          # Main config: events, keybindings, status bar, theme
├── projects.lua         # Workspace definitions  ← edit to add projects
├── help.sh              # Startup banner (prints legend, then hands off to shell)
├── new-workspace.sh     # Interactive wizard: prompts id/label/cwd → appends to projects.lua
└── install.ps1          # Windows setup: junction ~/.config/wezterm → ~/dotfiles/wezterm

~/.config/wezterm/       # Junction → ~/dotfiles/wezterm (no elevation needed)
session_state.lua        # Auto-generated on graceful close + every 30s (do not hand-edit)
```

```mermaid
graph TB
    subgraph OS["Single OS Window"]
        subgraph Launcher["Workspace: launcher"]
            HT[help tab\nstartup banner]
            ST[shell tab]
        end
        subgraph WS1["Workspace: cashcow  (ALT+2)"]
            A1[agent tab\nvsplit panes]
            D1[dev tab\nhsplit panes\npnpm dev]
            T1[test tab]
            G1[git tab\ngit log]
        end
        subgraph WS2["Workspace: life  (ALT+6)"]
            A2[agent tab]
            N2[notes tab]
            G2[git tab]
        end
    end

    StatusBar["Left status bar\n● workspace attention dots\nALT+N = project name"]

    OS --> StatusBar
```

---

## User Flows

### Cold start
```
WezTerm opens  →  launcher workspace  →  help tab shows banner + [Enter]
→  press Enter  →  login shell ready
→  press ALT+1–7 or ALT+P  →  workspace opens in same window
```

### Open a known project
```
ALT+P                fuzzy picker — shows pinned projects, discovered repos, [+] new
ALT+↑ / ALT+↓        cycle through open workspaces
ALT+0                return to launcher/help
```

### Open any repo (not in projects.lua)
```
ALT+P → scroll to repo  discovered repos from REPO_ROOTS appear below pinned projects
ALT+P → [+] New         PromptInputLine appears → type any path → workspace created
                         (directory is created if it doesn't exist)
```

### Add a permanent pinned project
```
Edit wezterm/projects.lua  add an entry with id/label/cwd/tabs
WezTerm hot-reloads        new project appears immediately in ALT+P picker
```

### Navigate within a workspace
```
ALT+← / ALT+→        prev / next tab
LEADER |             split pane right
LEADER -             split pane down
LEADER h/j/k/l       move between panes (vim-style)
LEADER z             zoom / unzoom active pane
```

### Get help
```
ALT+/                InputSelector overlay — full legend, fuzzy searchable, Enter to run
help tab             startup banner (re-open via ALT+0, tab 1)
```

---

## Key Binding Map

### Navigation (two axes, one modifier)

| Key | Action |
|-----|--------|
| `ALT+P` | Open workspace — fuzzy picker (● open, ○ closed) |
| `ALT+↑` / `ALT+↓` | Cycle workspaces up / down |
| `ALT+0` | Launcher / help workspace |
| `ALT+←` / `ALT+→` | Prev / next tab within workspace |
| `CTRL+SHIFT+T` | New tab |
| `CTRL+SHIFT+W` | Close tab |

### Panes (LEADER = ALT+Z, 1.5s window)

| Key | Action |
|-----|--------|
| `LEADER+\|` | Split pane right |
| `LEADER+-` | Split pane down |
| `LEADER+h/j/k/l` | Navigate panes (vim-style) |
| `LEADER+z` | Zoom / unzoom pane |

### Utility

| Key | Action |
|-----|--------|
| `ALT+/` | Key legend overlay (fuzzy searchable) |
| `LEADER+c` | Copy mode (vi-style scroll + select) |
| `CTRL+SHIFT+C/V` | Copy / paste |
| `CTRL+SHIFT+F` | Fullscreen |
| `CTRL+=` / `CTRL+-` / `CTRL+0` | Font size inc / dec / reset |

---

## Keybinding Conflict Reference

### Automatic detection
The config runs a duplicate-binding scan at load time. Collisions log to:
**Help → Show Debug Log Overlay** inside WezTerm (or `wezterm.log_warn` output).

### Windows-reserved (cannot bind — WezTerm cannot intercept these)

| Key | Reserved by |
|-----|------------|
| `ALT+F4` | Close active window (OS-level) |
| `ALT+TAB` / `ALT+SHIFT+TAB` | App switcher (OS-level) |
| `ALT+SPACE` | Window system menu |
| `ALT+ENTER` | Toggle fullscreen in some Windows contexts |
| `CTRL+ALT+DEL` | Security screen (OS-level, always intercepted) |
| `WIN+*` | All Windows key combinations |

### App-level conflicts (WezTerm wins when focused, but other apps grab when unfocused)

| Key | Grabbed by |
|-----|-----------|
| `CTRL+SHIFT+T` | New tab in Chrome/Edge/Firefox |
| `CTRL+SHIFT+W` | Close tab in Chrome/Edge/Firefox |
| `CTRL+SHIFT+F` | Find in Files in VS Code |
| `ALT+←` / `ALT+→` | Browser back/forward (only when browser is focused) |

### Known machine-specific conflicts (this machine)

| Key | Conflict |
|-----|---------|
| `CTRL+SPACE` | Super Whisper — reason LEADER was moved to `ALT+Z` |

### Safe zone — verified free on Windows 11

`ALT+P`, `ALT+/`, `ALT+0`, `ALT+↑↓←→`, `ALT+Z` (LEADER) — none of these are claimed by Windows globally or by common dev tools.
| `LEADER z` | Zoom / unzoom pane | |
| `LEADER r` | Registry regen | stock research macro |
| `LEADER b` | Backtest sweep | stock research macro |
| `LEADER d` | pnpm dev | web project macro |

LEADER = `ALT+Z` (1.5 s window)

---

## Default Pane Layouts

| Tab title | Layout | Reason |
|-----------|--------|--------|
| `agent` | vsplit (side-by-side) | monitor AI output alongside edits |
| `dev` | hsplit (top + bottom) | server output below, shell above |
| `cmd` | hsplit | same rationale as dev |
| `test` | hsplit | test output below |
| `sys` | hsplit | logs/metrics below |
| `git` / `notes` | none (single pane) | full width for readability |

Override per-tab in `projects.lua` with `layout = "vsplit"|"hsplit"|"none"`.

---

## Feature Status

### Done
- [x] Single OS window — workspaces share one window, no per-project popups
- [x] Lazy workspace spawning — only created when first opened
- [x] ALT+1–7 direct project access
- [x] ALT+P fuzzy project picker (single chord)
- [x] ALT+Z O open-by-path (ad-hoc workspace from any directory)
- [x] ALT+Left/Right workspace cycling
- [x] ALT+[/] tab cycling (no Windows-system conflict)
- [x] Default split layouts per tab name (projects.lua layout field)
- [x] Left status bar: open workspaces + attention dots (unseen output)
- [x] Session state: 30s flush + graceful-close save, restored on next open
- [x] New workspace wizard (new-workspace.sh → projects.lua hot-reload)
- [x] Crimson Noir theme (16 ANSI slots, tab bar, cursor, selection)
- [x] Startup help banner with [Enter] pause to prevent .bashrc clear wipe
- [x] LEADER key legend overlay (ALT+Z H — InputSelector, fuzzy searchable)
- [x] Junction-based install (no symlink elevation needed on Windows)
- [x] Git-tracked dotfiles at github.com/sibulus13/terminal-config

### In Progress
- [ ] **Crimson Noir refinement** — extract to `.toml`, WCAG contrast audit, gallery publish

### Planned
- [ ] **Persistent legend panel** — always-visible keybinding bar (requires Zellij or tmux)
- [ ] **Zellij or tmux integration** — see section below
- [ ] **Per-project LEADER macros** — context-aware macros that change per workspace
- [ ] **Cross-device sync** — verify install.ps1 works on a second machine

---

## Persistent Legend Panel — Options

WezTerm has no native widget/panel system. The status bar is the only persistent display area.

| Option | Effort | Quality | Windows support |
|--------|--------|---------|-----------------|
| Expand status bar (more hints) | Low | Low — cramped | Native |
| **tmux via MSYS2** | Medium | Good — persistent bottom bar | Yes (Git Bash / MSYS2) |
| **Zellij** | Medium | Best — plugin system, WASM widgets | WSL2 only (see below) |
| Wezterm + floating overlay | High | Partial — InputSelector only | Native |

### Zellij on Windows — Current Reality

Zellij is written in Rust and has a Windows build, but as of mid-2025:
- **Native Windows**: experimental binary exists; PTY support has known issues on raw Win32
- **WSL2**: full support, recommended path for Windows users
- **Your machine**: no WSL distro installed (confirmed during initial debug) — Zellij would require setting up WSL2 first

**If you want Zellij**: install WSL2 (`wsl --install`), then install Zellij in the WSL2 distro. Run WezTerm pointing at WSL2 bash as `default_prog`, with Zellij as the WSL2 shell startup program. WezTerm handles the GPU rendering and OS window; Zellij handles multiplexing + the persistent keybinding bar.

### tmux via MSYS2 (simpler path, no WSL2)

MSYS2 ships tmux natively. Steps:
1. Install MSYS2 (`winget install MSYS2.MSYS2`)
2. `pacman -S tmux` inside MSYS2
3. Point WezTerm's `default_prog` at MSYS2 bash with tmux autostart
4. Configure `~/.tmux.conf` status bar to show key legend

This keeps everything on native Windows with no WSL2 dependency.
