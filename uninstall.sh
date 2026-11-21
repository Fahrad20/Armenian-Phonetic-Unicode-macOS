#!/bin/bash
# Armenian Phonetic Unicode — one-line uninstaller for macOS.
#
#   curl -fsSL https://raw.githubusercontent.com/Fahrad20/Armenian-Phonetic-Unicode-macOS/main/uninstall.sh | bash

set -euo pipefail

TARGET="$HOME/Library/Keyboard Layouts/Armenian Phonetic Unicode.bundle"

if [ ! -e "$TARGET" ]; then
  echo "Ստեղնաշարը տեղադրված չէ։"
  exit 0
fi

rm -rf "$TARGET"
echo "✓  Հեռացված է։"
echo "Ավարտելու համար դուրս եկեք համակարգից (Log Out) և նորից մտեք։"
open "x-apple.systempreferences:com.apple.Keyboard-Settings" 2>/dev/null || true
