#!/bin/bash
# Exports the project for the web into build/web/.
set -euo pipefail

cd "$(dirname "$0")/.."
GODOT="${GODOT:-$(scripts/install-godot.sh)}"

mkdir -p build/web
"$GODOT" --headless --import
"$GODOT" --headless --export-release "Web" build/web/index.html
echo "Web build written to build/web/"
