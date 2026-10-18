# Claude Game 1

A Godot 4.5 project targeting the web (Compatibility renderer, single-threaded build so it runs on any static host).

## Scripts

- `scripts/install-godot.sh` — downloads Godot and the web export templates (skips what's already installed) and prints the binary path.
- `scripts/build-web.sh` — exports the game to `build/web/`. Serve that folder over HTTP (e.g. `python3 -m http.server -d build/web`) to play it.
- `scripts/check.sh` — parses every `.gd` file and runs the main scene headlessly, failing on script errors.

Set `GODOT=/path/to/godot` to use an existing install instead of downloading one.

In Claude Code cloud sessions, `.claude/hooks/session-start.sh` installs Godot automatically and exports `$GODOT`.
