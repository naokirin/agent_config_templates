#!/usr/bin/env bash
# Format edited Rust files with rustfmt when available.
# Triggered by Claude Code PostToolUse hook for Edit/Write tools.
# Receives JSON on stdin with tool_input.file_path.
set -euo pipefail

input=$(cat)

# Extract file_path: Claude Code uses tool_input.file_path; Cursor uses file_path at top level
if command -v jq &>/dev/null; then
  file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // .file_path // empty' 2>/dev/null) || exit 0
elif command -v python3 &>/dev/null; then
  file_path=$(printf '%s' "$input" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('tool_input', {}).get('file_path', '') or d.get('file_path', ''))
" 2>/dev/null) || exit 0
else
  exit 0
fi

if [[ -z "$file_path" || "$file_path" != *.rs || ! -f "$file_path" ]]; then
  exit 0
fi

root="${CLAUDE_PROJECT_DIR:-.}"
if command -v rustfmt &>/dev/null; then
  (cd "$root" && rustfmt "$file_path" 2>/dev/null) || true
fi

exit 0
