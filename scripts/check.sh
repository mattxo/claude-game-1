#!/bin/bash
# Parses every GDScript file and runs the main scene headlessly for a few frames.
set -euo pipefail

cd "$(dirname "$0")/.."
GODOT="${GODOT:-$(scripts/install-godot.sh)}"

"$GODOT" --headless --import

status=0
while IFS= read -r -d '' script; do
  if ! "$GODOT" --headless --check-only --script "$script"; then
    echo "Parse error: $script" >&2
    status=1
  fi
done < <(find . -name '*.gd' -not -path './.godot/*' -print0)

# Smoke test: fail on any script error while running the main scene.
log="$("$GODOT" --headless --quit-after 60 2>&1)"
echo "$log"
if grep -q "SCRIPT ERROR" <<<"$log"; then
  status=1
fi

exit $status
