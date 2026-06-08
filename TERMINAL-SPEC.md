# Terminal — Spec

## Vision

One window. Every project, one keystroke away.
Keyboard-driven. Left hand navigates, right hand works.
Context always visible. Never lost between restarts.

---

## How it's built

```
WezTerm  (OS window · GPU rendering · keybindings · theme)
  └─ Workspaces  (one per project, lazy — only spawned on first open)
       └─ Tabs  (agent / dev / test / git — defined in projects.lua)
            └─ Panes  (vsplit for agent, hsplit for dev/test)

[Planned]
WezTerm → WSL2 → Zellij
                   └─ ~/contexts/<project>.md  (persistent left sidebar, auto-refresh)
```

```
dotfiles/wezterm/
├── wezterm.lua      keybindings, theme, status bar, workspace logic
├── projects.lua     workspace definitions  ← edit here to add a project
├── help.sh          startup banner
└── install.ps1      Windows setup (junction ~/.config/wezterm → ~/dotfiles/wezterm)
```

---

## Keys

**LEADER = `ALT+Z`** — hold ALT, tap Z, release — 1.5s window for the next key.

### Workspaces & tabs

| Key | Action |
|-----|--------|
| `ALT+P` | Open workspace picker — pinned · discovered repos · `[+]` new |
| `ALT+↑` / `ALT+↓` | Cycle open workspaces |
| `ALT+0` | Jump to launcher |
| `ALT+←` / `ALT+→` | Prev / next tab |
| `CTRL+SHIFT+T` | New tab |
| `CTRL+SHIFT+W` | Close tab |

### Panes

| Key | Action |
|-----|--------|
| `LEADER+\|` | Split right |
| `LEADER+-` | Split down |
| `LEADER+h/j/k/l` | Move focus (vim directions) |
| `LEADER+z` | Zoom / unzoom pane |

### Utility

| Key | Action |
|-----|--------|
| `ALT+/` | Key legend — fuzzy, Enter executes selected action |
| `LEADER+c` | Copy mode (vi scroll + select) |
| `CTRL+SHIFT+C / V` | Copy / paste |
| `CTRL+SHIFT+F` | Fullscreen |
| `CTRL+= / - / 0` | Font size |

---

## Common flows

**Open a project**
```
ALT+P  →  type name  →  Enter
```

**Open a repo not in projects.lua**
```
ALT+P  →  scroll to discovered repos section  →  Enter
```

**Create a brand-new workspace at any path**
```
ALT+P  →  [+] New workspace  →  type path  →  Enter
(directory created if it doesn't exist)
```

**Permanently add a project**
```
Edit wezterm/projects.lua  →  save  →  appears in ALT+P immediately (hot-reload)
```

**Get unstuck**
```
ALT+/  to see all keys
```

---

## Conflict reference

**Windows owns these — cannot be rebound:**
`ALT+F4` · `ALT+TAB` · `ALT+SPACE` · `WIN+*` · `CTRL+ALT+DEL`

**App-level (WezTerm wins when focused):**
`CTRL+SHIFT+T/W` grabbed by browsers · `ALT+←→` grabbed by browsers

**This machine:**
`CTRL+SPACE` — Super Whisper (why LEADER is `ALT+Z`, not `CTRL+SPACE`)

**Safe zone — verified free:**
`ALT+P` · `ALT+/` · `ALT+0` · `ALT+↑↓←→` · `ALT+Z`

---

## Feature status

**Done**
- [x] Single OS window — no per-project close prompts
- [x] Lazy workspace spawning
- [x] `ALT+P` fuzzy picker — pinned, discovered, new
- [x] Workspace cycling `ALT+↑↓`, tab cycling `ALT+←→`
- [x] Auto-discovered repos from `REPO_ROOTS` (filters files by extension)
- [x] New workspace from any path — creates directory if missing
- [x] Status bar — open workspaces, attention dots, legend hint, clock
- [x] Session state — 30s flush + graceful-close save
- [x] Startup banner with `[Enter]` pause
- [x] `ALT+/` executable legend — LEGEND is single source of truth
- [x] Crimson Noir theme
- [x] Duplicate binding validator at load time
- [x] Git-tracked dotfiles

**Planned**
- [ ] `LEADER+W` — close current pane
- [ ] Crimson Noir `.toml` + WCAG contrast audit
- [ ] WSL2 + Zellij — persistent per-project context sidebar
- [ ] Per-workspace LEADER macros (e.g. `LEADER+D` runs the right dev command)
- [ ] Cross-device install verification
