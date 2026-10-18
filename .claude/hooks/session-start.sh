#!/bin/bash
# Installs Godot and its web export templates in Claude Code cloud sessions.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

GODOT="$("$CLAUDE_PROJECT_DIR/scripts/install-godot.sh")"
echo "export GODOT=\"$GODOT\"" >> "$CLAUDE_ENV_FILE"
