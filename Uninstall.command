#!/bin/bash
set -e

TARGET="$HOME/Library/Keyboard Layouts/Armenian Phonetic Unicode.bundle"

if [ ! -e "$TARGET" ]; then
  echo "The keyboard layout is not installed in your user Library."
else
  rm -rf "$TARGET"
  echo "Removed. Log out and log back in to finish uninstalling."
fi

open "x-apple.systempreferences:com.apple.Keyboard-Settings"
read -r -p "Press Enter to close..."
