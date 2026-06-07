# Claude Code — Dotfiles / Terminal Config Project

## Spec-First Protocol (mandatory)

Before making ANY change to this repo:

1. **State the intent** in one sentence: what is changing and why.
2. **Update the relevant spec section** in `TERMINAL-SPEC.md` or `PROJECTS.md`:
   - Move the item from Planned → In Progress with today's date.
   - Add the intent under the item.
3. **Make the change.**
4. **Update the spec again**: move item to Done, note what was actually implemented vs. intended.
5. **Update `contexts/terminal-config.md`** with current status and next steps.

This creates a paper trail and forces clarity before action. Do not skip steps 1–2.

---

## Session Resumption

At the start of every session:
1. Read `contexts/terminal-config.md` — this is the single source of truth for current state.
2. Read `TERMINAL-SPEC.md` Feature Status section.
3. Read `PROJECTS.md` for open project details.
4. Report a one-paragraph summary of where we are before asking what to work on.

At the end of every session (or before context compaction):
1. Update `contexts/terminal-config.md` with what changed and what's next.
2. Commit the context file alongside any code changes.

---

## Repo Layout

```
dotfiles/
├── CLAUDE.md              ← you are here — session protocol
├── TERMINAL-SPEC.md       ← architecture, keybindings, feature status
├── PROJECTS.md            ← open project details (Zellij, Crimson Noir, …)
├── contexts/
│   └── terminal-config.md ← live session context (what's in progress right now)
├── wezterm/               ← WezTerm config (hot-reloads on save)
│   ├── wezterm.lua        ← main config: events, keybindings, status bar, theme
│   ├── projects.lua       ← workspace definitions (edit to add projects)
│   ├── help.sh            ← startup banner
│   └── new-workspace.sh   ← interactive wizard
└── zellij/                ← Zellij config (awaiting WSL2)
    ├── config.kdl
    ├── layouts/
    ├── init-context.sh
    └── install-wsl.sh
```

## Style Rules
- Keybinding changes: always update LEGEND in wezterm.lua AND help.sh in the same commit.
- New workspace feature: update projects.lua comment header to explain new fields.
- Zellij changes: test in WSL2 before committing (kdl syntax errors are silent).
- Commit message prefix: `feat:` new capability, `fix:` bug, `refactor:` restructure, `chore:` maintenance.
