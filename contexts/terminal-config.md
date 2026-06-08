# terminal-config — Session Context

> This file is the session handoff. Claude reads it at session start.
> Update it at the end of every work session before committing.
> Last updated: 2026-06-07

---

## Current Status

**Phase:** Core WezTerm config complete. Zellij config written, awaiting WSL2 install.

### What works right now
- Single OS window — all workspaces share one WezTerm window (no multi-window close prompts)
- Lazy workspace spawning — projects open on demand via ALT+P picker
- ALT+P fuzzy workspace picker (● open · ○ closed); ALT+↑/↓ cycle workspaces
- ALT+←/→ cycle tabs within workspace
- Default pane splits per tab type: agent=vsplit, dev/cmd/test=hsplit
- Left status bar: shows **only open** workspaces with attention dots (● = unseen output)
- Right status bar: persistent `ALT+/ legend` reminder + clock
- Session state: auto-saved every 30s + on graceful close (session_state.lua)
- Startup help banner with [Enter] pause (help.sh)
- ALT+/ → full legend overlay (fuzzy searchable; **pressing Enter executes the action**)
- LEGEND is single source of truth — `config.keys` references `LEGEND[i].action` directly
- Crimson Noir theme: bg #0e0014, accent #c4185c, 16 ANSI slots configured
- Dotfiles versioned at github.com/sibulus13/terminal-config

### What's blocked / waiting
- Zellij persistent context panel: config ready (`zellij/`), needs `wsl --install` + restart
- Once WSL2 is up: run `bash /mnt/c/Users/Michael/dotfiles/zellij/install-wsl.sh`

---

## In Progress

_Nothing actively in flight right now (just completed executable legend — see decisions below)._

---

## Next Steps (priority order)

1. **WSL2 + Zellij** — user runs `wsl --install` (admin PS, needs restart), then install-wsl.sh
2. **Per-project context files** — after Zellij, run `init-context.sh` in each project root
3. **Crimson Noir .toml** — extract theme from wezterm.lua into `wezterm/colors/crimson-noir.toml`
4. **WCAG audit** — verify all 16 ANSI pairs against bg #0e0014 at webaim.org/resources/contrastchecker
5. **Per-project LEADER macros** — macros that change based on active workspace (e.g. LEADER+d runs the right dev command per project)

---

## Key Decisions Made This Session

| Decision | Rationale |
|----------|-----------|
| `mux.spawn_window` → `SwitchToWorkspace + call_after` | Prevents multiple OS windows requiring close confirmations |
| LEADER = ALT+Z | Left-hand only; avoids CTRL+Space (Super Whisper conflict) |
| Tab cycling: ALT+←/→; workspace cycling: ALT+↑/↓ | Two axes, one modifier — consistent mental model |
| Zellij via WSL2, not native Windows | Native Zellij Windows binary has PTY issues as of mid-2025 |
| Context files: `~/contexts/<project>.md` | Watch-able by Zellij sidebar, editable by Claude/user |
| Single `contexts/terminal-config.md` per project | One file = one source of truth; no hunting across multiple docs |
| Removed ALT+1-7 workspace shortcuts | User wants command-palette UX, not slot memorization |
| `ALT+P` picker built dynamically | Shows ● for open workspaces vs. ○ closed — live status |
| Session state saves `active_tab_idx` not `tab_id` | tab_id resets each launch; index is stable across restarts |
| LEGEND as single source of truth | `config.keys` references `LEGEND[i].action` — no duplicate action definitions |
| ALT+/ legend Enter executes the action | `PICK_WORKSPACE` stored as variable; shared between LEGEND[1] and `config.keys` |

---

## Architecture Snapshot

```
WezTerm (OS window, GPU renderer, keybindings)
  └─ Workspaces (one per project, lazy-loaded)
       └─ Tabs (agent/dev/test/git per project definition)
            └─ Panes (vsplit for agent, hsplit for dev/test)

[Future] WezTerm → WSL2 → Zellij (persistent context sidebar)
                              └─ ~/contexts/<project>.md (30% left panel)
```

---

## Config File Map

| File | When to edit |
|------|-------------|
| `wezterm/projects.lua` | Add/modify project workspaces |
| `wezterm/wezterm.lua` | Keybindings, theme, status bar, events |
| `wezterm/help.sh` | Update startup banner text |
| `zellij/config.kdl` | Zellij keybindings / theme (after WSL2) |
| `zellij/layouts/*.kdl` | Pane layouts (after WSL2) |
| `TERMINAL-SPEC.md` | Architecture decisions, feature status |
| `PROJECTS.md` | Open project detail and setup steps |
| `contexts/terminal-config.md` | ← this file — current state |
