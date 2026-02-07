#!/usr/bin/env bash
# Format edited shell script files with shfmt when available.
# Cursor: receives file path as first argument when used from afterFileEdit.
set -euo pipefail

file_path="${1:-}"

# Claude Code PostToolUse hook sends JSON on stdin
if [[ -z "$file_path" ]] && [[ -t 0 ]]; then
  input=$(cat 2>/dev/null || true)
  if [[ -n "$input" ]]; then
    if command -v jq &>/dev/null; then
      file_path=$(printf '%s' "$input" | jq -r '.file_path // empty' 2>/dev/null) || true
    elif command -v python3 &>/dev/null; then
      file_path=$(printf '%s' "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('file_path',''))" 2>/dev/null) || true
    fi
  fi
fi

if [[ -z "$file_path" ]]; then
  exit 0
fi
case "$file_path" in
  *.sh) ;;
  *) exit 0 ;;
esac
[[ -f "$file_path" ]] || exit 0

if command -v shfmt &>/dev/null; then
  root="${CLAUDE_PROJECT_DIR:-.}"
  (cd "$root" && shfmt -w -i 2 -ci "$file_path" 2>/dev/null) || true
fi
exit 0
