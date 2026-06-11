# Terminal Config — Session Handoff

> Claude reads this at session start. Update before committing.
> Last updated: 2026-06-11

---

## Where things stand

Core WezTerm config is complete and stable.
Zellij config is written and committed — blocked on WSL2 install.

**Working**

- One OS window, all workspaces share it
- `ALT+P` — workspace picker: pinned projects · discovered repos · `[+] new`
- `ALT+↑ / ↓` — cycle open workspaces
- `ALT+← / →` — cycle tabs within a workspace
- `ALT+/` — key legend overlay; pressing Enter on any entry executes it
- Left status bar — open workspaces only, attention dots for unseen output
- Right status bar — persistent `ALT+/ legend` hint + clock
- Session state — auto-saved every 30s and on graceful close
- Startup banner — `help.sh` with `[Enter]` pause before shell
- Crimson Noir theme — bg `#0e0014`, accent `#c4185c`
- Dotfiles versioned at `github.com/sibulus13/terminal-config`

**Done (2026-06-11)**

- Zellij 0.44.3 installed in WSL2 (Ubuntu 24.04, `~/.local/bin/zellij`)
- Config symlinked: `~/.config/zellij` → `/mnt/c/Users/Michael/dotfiles/zellij`
- Layouts: `workspace.kdl` (default), `agent.kdl`
- PATH added to `~/.bashrc`

---

## What's next

1. Per-project context files — run `bash /mnt/c/Users/Michael/dotfiles/zellij/init-context.sh` in each project root inside WSL2
2. First launch — open WezTerm, `wsl -d Ubuntu-24.04`, then `zellij` or `zellij --layout agent`
3. Crimson Noir `.toml` — extract theme out of wezterm.lua, WCAG audit
4. `LEADER+W` — close current pane (agreed, not yet implemented)
5. Per-workspace LEADER macros — e.g. `LEADER+D` runs `pnpm dev` in the right project

---

## Key decisions

| What | Why |
|------|-----|
| Single OS window via `SwitchToWorkspace` | No per-project close confirmations |
| LEADER = `ALT+Z` | Left-hand only; avoids CTRL+Space (Super Whisper) |
| Workspaces = `ALT+↑↓`, tabs = `ALT+←→` | Two axes, one modifier — consistent |
| `ALT+P` picker built dynamically | Live ● / ○ status; scans REPO_ROOTS for undiscovered repos |
| LEGEND is single source of truth | `config.keys` references `LEGEND[i].action` — bindings can't drift |
| `active_tab_idx` not `tab_id` in session state | tab_id resets each launch; index is stable |
| Zellij via WSL2, not native Windows | Native binary has PTY issues on Win32 as of mid-2025 |

---

## File map

| File | Purpose |
|------|---------|
| `wezterm/wezterm.lua` | Keybindings, theme, status bar, events — main config |
| `wezterm/projects.lua` | Workspace definitions — edit to add projects |
| `wezterm/help.sh` | Startup banner |
| `zellij/` | Multiplexer config (pending WSL2) |
| `TERMINAL-SPEC.md` | Vision, architecture, key binding reference |
| `contexts/terminal-config.md` | This file |
