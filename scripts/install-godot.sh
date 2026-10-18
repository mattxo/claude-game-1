#!/bin/bash
# Installs the Godot editor binary and the web export templates.
# Idempotent: skips anything already present. Prints the binary path on stdout.
set -euo pipefail

GODOT_VERSION="${GODOT_VERSION:-4.5.1}"
INSTALL_DIR="${GODOT_INSTALL_DIR:-$HOME/.local/share/godot-bin/$GODOT_VERSION}"
TEMPLATES_DIR="$HOME/.local/share/godot/export_templates/${GODOT_VERSION}.stable"
BASE_URL="https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable"
BIN="$INSTALL_DIR/Godot_v${GODOT_VERSION}-stable_linux.x86_64"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

if [ ! -x "$BIN" ]; then
  echo "Downloading Godot $GODOT_VERSION..." >&2
  mkdir -p "$INSTALL_DIR"
  curl -sSLf -o "$tmp/godot.zip" "$BASE_URL/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip"
  unzip -oq "$tmp/godot.zip" -d "$INSTALL_DIR"
  chmod +x "$BIN"
fi

if [ ! -f "$TEMPLATES_DIR/web_nothreads_release.zip" ]; then
  echo "Downloading Godot $GODOT_VERSION export templates (~1 GB, web templates only are kept)..." >&2
  mkdir -p "$TEMPLATES_DIR"
  curl -sSLf -o "$tmp/templates.tpz" "$BASE_URL/Godot_v${GODOT_VERSION}-stable_export_templates.tpz"
  unzip -oq "$tmp/templates.tpz" 'templates/web*' -d "$tmp/x"
  rm "$tmp/templates.tpz"
  mv -f "$tmp"/x/templates/* "$TEMPLATES_DIR/"
fi

echo "$BIN"
