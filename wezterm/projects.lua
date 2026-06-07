-- ─────────────────────────────────────────────────────────────────────────────
-- projects.lua — Edit this file to add, remove, or modify project workspaces.
--
-- Each entry becomes a named WezTerm workspace with its own tab layout.
-- Fields per project:
--   id      (string)  internal workspace name — no spaces
--   label   (string)  display name in the picker
--   cwd     (string)  root directory (use forward slashes)
--   tabs    (table)   list of tabs, each with:
--     title   (string)           tab label
--     cmd     (string | nil)     shell command to run; nil = plain shell
--     resume  (boolean | nil)    if true, this tab's command is re-launched on session restore
--
-- To add a new project: duplicate any entry, set a unique id, update cwd and tabs.
-- WESTERN / WezTerm reloads the config automatically — no restart required.
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    id    = "stock-research",
    label = "Stock / Research 2026",
    cwd   = "D:/repo/Stock/Research 2026",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "sys",     cmd = "python scripts/system_report.py; exec bash",             resume = false },
      { title = "test",    cmd = "exec bash",                                              resume = false },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "cashcow",
    label = "Cashcow",
    cwd   = "D:/repo/web/cashcow",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "dev",     cmd = "pnpm dev",                                               resume = true  }, -- dev server: always resume
      { title = "test",    cmd = "exec bash",                                              resume = false },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "sunset",
    label = "Sunset",
    cwd   = "D:/repo/web/sunset",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "dev",     cmd = "pnpm dev",                                               resume = true  },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "tarive",
    label = "Tarive",
    cwd   = "D:/repo/web/Tarive",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "dev",     cmd = "exec bash",                                              resume = false },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "europe",
    label = "Europe 2026 App",
    cwd   = "D:/repo/europe-2026",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "dev",     cmd = "pnpm dev",                                               resume = true  },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "life",
    label = "Life",
    cwd   = "D:/repo/Life",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "notes",   cmd = "exec bash",                                              resume = false },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
  {
    id    = "si8",
    label = "SI8 Landing",
    cwd   = "D:/repo/web/si8-tech-landing-page",
    tabs  = {
      { title = "agent",   cmd = nil,                                                      resume = false },
      { title = "dev",     cmd = "exec bash",                                              resume = false },
      { title = "git",     cmd = "git log --oneline -20; exec bash",                      resume = false },
    },
  },
}
