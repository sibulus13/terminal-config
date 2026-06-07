#!/usr/bin/env bash
# Add a new project workspace to projects.lua interactively.
# Run via ALT+Z N inside WezTerm.

PROJECTS_FILE="$(dirname "$0")/projects.lua"

echo ""
echo "  ── New Workspace ──────────────────────────────"
echo ""

read -rp "  Workspace ID (no spaces, e.g. my-project): " WS_ID
if [[ -z "$WS_ID" ]]; then echo "  Aborted."; exec bash -l; fi

read -rp "  Display label (e.g. My Project):           " WS_LABEL
if [[ -z "$WS_LABEL" ]]; then echo "  Aborted."; exec bash -l; fi

read -rp "  Root directory (e.g. D:/repo/my-project):  " WS_CWD
if [[ -z "$WS_CWD" ]]; then echo "  Aborted."; exec bash -l; fi

# Strip trailing closing brace from projects.lua, append the new entry, re-close
ENTRY=$(cat << LUAEOF
  {
    id    = "$WS_ID",
    label = "$WS_LABEL",
    cwd   = "$WS_CWD",
    tabs  = {
      { title = "agent", cmd = nil,                             resume = false },
      { title = "dev",   cmd = "exec bash",                    resume = false },
      { title = "git",   cmd = "git log --oneline -20; exec bash", resume = false },
    },
  },
LUAEOF
)

# Inject before the final closing `}` of the return table
python3 - "$PROJECTS_FILE" "$ENTRY" << 'PYEOF'
import sys

path  = sys.argv[1]
entry = sys.argv[2]

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Find last `}` and insert the new entry before it
last_brace = content.rfind('\n}')
if last_brace == -1:
    print("ERROR: could not find closing } in projects.lua", file=sys.stderr)
    sys.exit(1)

new_content = content[:last_brace] + '\n' + entry + content[last_brace:]

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("  Workspace added.")
PYEOF

if [[ $? -eq 0 ]]; then
    echo ""
    echo "  ✓ '$WS_ID' added to projects.lua"
    echo "  WezTerm will hot-reload the config automatically."
    echo "  Press ALT+$(grep -c 'id    =' "$PROJECTS_FILE") to open it."
    echo ""
fi

exec bash -l
