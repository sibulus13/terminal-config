-- ─────────────────────────────────────────────────────────────────────────────
-- projects.lua — Edit to add, remove, or modify project workspaces.
--
-- Standard 2-tab layout per workspace:
--   Tab 1 "agent"  — single pane, Claude agent work
--   Tab 2 "shell"  — vsplit, two plain shells for orchestration / running things
--
-- Fields per project:
--   id      (string)  internal workspace name — no spaces
--   label   (string)  display name in the picker
--   cwd     (string)  root directory (forward slashes)
--   tabs    (table)   list of tabs, each with:
--     title   (string)           tab label
--     cmd     (string | nil)     shell command for the first (left) pane; nil = plain shell
--     layout  (string | nil)     "vsplit" | "hsplit" | "none" | nil (inherits DEFAULT_LAYOUTS)
--     resume  (boolean | nil)    re-run cmd on session restore
--
-- ALT+SHIFT+←/→ cycles tabs. ALT+←/→/↑/↓ navigates panes (wraps to adjacent tab at edge).
-- WezTerm hot-reloads on save — no restart needed.
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    id    = "stock-research",
    label = "Stock / Research 2026",
    cwd   = "D:/repo/Stock/Research 2026",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "cashcow",
    label = "Cashcow",
    cwd   = "D:/repo/web/cashcow",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "sunset",
    label = "Sunset",
    cwd   = "D:/repo/web/sunset",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "tarive",
    label = "Tarive",
    cwd   = "D:/repo/web/Tarive",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "europe",
    label = "Europe 2026 App",
    cwd   = "D:/repo/europe-2026",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "life",
    label = "Life",
    cwd   = "D:/repo/Life",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
  {
    id    = "si8",
    label = "SI8 Landing",
    cwd   = "D:/repo/web/si8-tech-landing-page",
    tabs  = {
      { title = "agent", cmd = "claude --continue", layout = "none", resume = true },
      { title = "shell", cmd = nil, layout = "vsplit", resume = false },
    },
  },
}
