#!/usr/bin/env bash
# Set wallpaper on macOS using AppleScript
# Usage: darwin-set-wallpaper.sh <mode> <path-or-list-file>
#   mode: "exact" - set specific wallpaper path
#         "list"  - pick random wallpaper from list file (one path per line)

set -euo pipefail

[[ $# -eq 2 ]] || {
  echo "Usage: $0 <exact|list> <wallpaper-path|wallpaper-list-file>" >&2
  exit 1
}

MODE="$1"
ARG="$2"

case "$MODE" in
  exact)
    WALLPAPER_PATH="$ARG"
    ;;
  list)
    [[ -r "$ARG" ]] || { echo "Cannot read: $ARG" >&2; exit 1; }
    # Read wallpaper paths from the file (one path per line)
    # Filter out empty lines
    mapfile -t WALLPAPERS < <(grep -v '^[[:space:]]*$' "$ARG")
    # Check if any wallpapers were found
    (( ${#WALLPAPERS[@]} > 0 )) || { echo "No wallpapers found in: $ARG" >&2; exit 1; }
    WALLPAPER_PATH="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"
    ;;
  *)
    echo "Invalid mode: $MODE. Must be 'exact' or 'list'" >&2
    exit 1
    ;;
esac

# Escape double quotes for AppleScript
osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"${WALLPAPER_PATH//\"/\\\"}\""
