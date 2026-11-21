#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE="$SCRIPT_DIR/Keyboard Layout/Armenian Phonetic Unicode.bundle"
TARGET="$HOME/Library/Keyboard Layouts/Armenian Phonetic Unicode.bundle"

if [ ! -d "$SOURCE" ]; then
  echo "Keyboard layout bundle not found."
  read -r -p "Press Enter to close..."
  exit 1
fi

mkdir -p "$HOME/Library/Keyboard Layouts"

if [ -e "$TARGET" ]; then
  rm -rf "$TARGET"
fi

cp -R "$SOURCE" "$TARGET"
xattr -cr "$TARGET" 2>/dev/null || true

echo "Installed: $TARGET"
echo "If the layout does not appear immediately, log out and log back in (or reboot)."
open "x-apple.systempreferences:com.apple.Keyboard-Settings"
read -r -p "Press Enter to close..."
