#!/usr/bin/env bash
# Create a context file for the current directory.
# Run once per project: ./init-context.sh
# The context pane watches ~/contexts/<project>.md and refreshes every 3s.

CONTEXT_DIR="$HOME/contexts"
mkdir -p "$CONTEXT_DIR"

PROJECT=$(basename "$PWD")
FILE="$CONTEXT_DIR/$PROJECT.md"

if [[ -f "$FILE" ]]; then
  echo "Context already exists: $FILE"
  echo "Edit it directly or run: nano $FILE"
  exit 0
fi

cat > "$FILE" << TEMPLATE
# $PROJECT

## Goal
<!-- One-line: what this workspace is for -->

## In Progress
- [ ]

## Up Next
- [ ]

## Done
- [x]

## Notes
<!-- system state, gotchas, links -->
TEMPLATE

echo "Created: $FILE"
echo "The context pane will pick it up within 3s."
echo ""
echo "Edit with: nano $FILE"
