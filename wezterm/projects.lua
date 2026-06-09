-- ─────────────────────────────────────────────────────────────────────────────
-- projects.lua — Edit to add, remove, or modify project workspaces.
--
-- Fields per project:
--   id      (string)  internal workspace name — no spaces
--   label   (string)  display name in the picker
--   cwd     (string)  root directory (forward slashes)
--   tabs    (table)   list of tabs, each with:
--     title   (string)           tab label
--     cmd     (string | nil)     shell command; nil = plain shell
--     layout  (string | nil)     pane split on open:
--                                  "vsplit"  — two side-by-side panes  (agent default)
--                                  "hsplit"  — pane above + pane below  (dev default)
--                                  "none"    — single pane, no split
--                                  nil       — uses DEFAULT_LAYOUTS from wezterm.lua
--     resume  (boolean | nil)    re-run cmd on session restore
--
-- DEFAULT_LAYOUTS in wezterm.lua applies when layout = nil:
--   agent tabs → vsplit    dev/cmd/test tabs → hsplit
--
-- WezTerm hot-reloads on save — no restart needed.
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    id    = "stock-research",
    label = "Stock / Research 2026",
    cwd   = "D:/repo/Stock/Research 2026",
    tabs  = {
      -- Two side-by-side agent panes for running parallel Claude agents.
      { title = "agent",  cmd = nil,                               layout = nil,           resume = false },
      { title = "agent",  cmd = nil,                               layout = nil,           resume = false },
      -- Triple layout: left=orchestrator, top-right=backend, bottom-right=frontend.
      -- Used to verify triple_right split and layout-save/restore behavior.
      { title = "run",    cmd = nil,                               layout = "triple_right", resume = false },
      { title = "git",    cmd = "git log --oneline -20; exec bash", layout = "none",        resume = false },
    },
  },
  {
    id    = "cashcow",
    label = "Cashcow",
    cwd   = "D:/repo/web/cashcow",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,      resume = false },
      { title = "dev",   cmd = "pnpm dev",                         layout = "hsplit", resume = true  },
      { title = "test",  cmd = "exec bash",                        layout = "hsplit", resume = false },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none",   resume = false },
    },
  },
  {
    id    = "sunset",
    label = "Sunset",
    cwd   = "D:/repo/web/sunset",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,      resume = false },
      { title = "dev",   cmd = "pnpm dev",                         layout = "hsplit", resume = true  },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none",   resume = false },
    },
  },
  {
    id    = "tarive",
    label = "Tarive",
    cwd   = "D:/repo/web/Tarive",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,      resume = false },
      { title = "dev",   cmd = "exec bash",                        layout = "hsplit", resume = false },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none",   resume = false },
    },
  },
  {
    id    = "europe",
    label = "Europe 2026 App",
    cwd   = "D:/repo/europe-2026",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,      resume = false },
      { title = "dev",   cmd = "pnpm dev",                         layout = "hsplit", resume = true  },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none",   resume = false },
    },
  },
  {
    id    = "life",
    label = "Life",
    cwd   = "D:/repo/Life",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,    resume = false },
      { title = "notes", cmd = "exec bash",                        layout = "none", resume = false },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none", resume = false },
    },
  },
  {
    id    = "si8",
    label = "SI8 Landing",
    cwd   = "D:/repo/web/si8-tech-landing-page",
    tabs  = {
      { title = "agent", cmd = nil,                                layout = nil,      resume = false },
      { title = "dev",   cmd = "exec bash",                        layout = "hsplit", resume = false },
      { title = "git",   cmd = "git log --oneline -20; exec bash", layout = "none",   resume = false },
    },
  },
}
