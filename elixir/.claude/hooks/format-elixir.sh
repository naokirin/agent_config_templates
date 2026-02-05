#!/usr/bin/env bash
# Format edited Elixir files with mix format when available.
# Receives JSON on stdin from Claude Code PostToolUse hook; extracts file_path and runs mix format.
set -euo pipefail
input=$(cat)

# Extract file_path from JSON (tool_input.file_path or similar from Claude Code hook payload)
if command -v jq &>/dev/null; then
  file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // .file_path // empty' 2>/dev/null) || exit 0
elif command -v python3 &>/dev/null; then
  file_path=$(printf '%s' "$input" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    file_path = d.get('tool_input', {}).get('file_path') or d.get('file_path', '')
    print(file_path or '')
except Exception:
    print('')
" 2>/dev/null) || exit 0
else
  exit 0
fi

if [[ -z "$file_path" ]]; then
  exit 0
fi
case "$file_path" in
  *.ex|*.exs) ;;
  *) exit 0 ;;
esac
[[ -f "$file_path" ]] || exit 0

root="${CLAUDE_PROJECT_DIR:-.}"
if command -v mix &>/dev/null && [[ -f "$root/mix.exs" ]]; then
  (cd "$root" && mix format "$file_path" 2>/dev/null) || true
fi
exit 0
