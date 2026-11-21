#!/bin/bash
# Armenian Phonetic Unicode — one-line installer for macOS.
#
#   curl -fsSL https://raw.githubusercontent.com/Fahrad20/Armenian-Phonetic-Unicode-macOS/main/install.sh | bash
#
# What it does (nothing else):
#   1. downloads this repository as a .tar.gz from GitHub into a temp folder
#   2. copies "Armenian Phonetic Unicode.bundle" to ~/Library/Keyboard Layouts
#   3. removes the temp folder and opens System Settings > Keyboard
#
# No sudo, no background processes, nothing is installed outside ~/Library/Keyboard Layouts.

set -euo pipefail

REPO="${APU_REPO:-Fahrad20/Armenian-Phonetic-Unicode-macOS}"
BRANCH="${APU_BRANCH:-main}"
URL="${APU_URL:-https://codeload.github.com/$REPO/tar.gz/refs/heads/$BRANCH}"

BUNDLE="Armenian Phonetic Unicode.bundle"
DEST_DIR="$HOME/Library/Keyboard Layouts"
TARGET="$DEST_DIR/$BUNDLE"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Այս տեղադրիչը միայն macOS-ի համար է։"
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "⬇  Ներբեռնվում է…"
if ! curl -fsSL "$URL" | tar -xz -C "$TMP"; then
  echo "✗  Ներբեռնումը ձախողվեց։ Ստուգեք ինտերնետային կապը։"
  exit 1
fi

SOURCE="$(find "$TMP" -maxdepth 4 -type d -name "$BUNDLE" | head -n 1)"
if [ -z "$SOURCE" ]; then
  echo "✗  Ստեղնաշարի փաթեթը չի գտնվել ներբեռնված արխիվում։"
  exit 1
fi

echo "📦  Տեղադրվում է…"
mkdir -p "$DEST_DIR"
rm -rf "$TARGET"
cp -R "$SOURCE" "$TARGET"
xattr -cr "$TARGET" 2>/dev/null || true

echo ""
echo "✓  Տեղադրումն ավարտված է։"
echo "   $TARGET"
echo ""
echo "Հաջորդ քայլը՝ դուրս եկեք համակարգից (Log Out) և նորից մտեք,"
echo "ապա System Settings → Keyboard → Text Input → Edit… → «+» → Armenian։"

# Opening the settings pane is a convenience; ignore failures (e.g. over SSH).
open "x-apple.systempreferences:com.apple.Keyboard-Settings" 2>/dev/null || true
