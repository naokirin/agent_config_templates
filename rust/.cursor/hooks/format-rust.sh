#!/usr/bin/env bash
# Format edited Rust files with rustfmt when available.
# Receives JSON on stdin from Cursor's afterFileEdit hook; extracts file_path and runs rustfmt.
set -euo pipefail
input=$(cat)
file_path=$(printf '%s' "$input" | ruby -rjson -e 'puts JSON.parse(STDIN.read).dig("file_path")' 2>/dev/null) || exit 0
if [[ -z "$file_path" || "$file_path" != *.rs || ! -f "$file_path" ]]; then
  exit 0
fi
root="${CURSOR_PROJECT_DIR:-.}"
if command -v rustfmt &>/dev/null; then
  (cd "$root" && rustfmt "$file_path" 2>/dev/null) || true
fi
exit 0
