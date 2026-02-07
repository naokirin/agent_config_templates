#!/usr/bin/env bash
# Format edited C# files with dotnet format when available.
# Receives JSON on stdin from Claude Code PostToolUse hook; extracts file_path and runs dotnet format.
set -euo pipefail
input=$(cat)
file_path=$(printf '%s' "$input" | ruby -rjson -e 'data = JSON.parse(STDIN.read); puts data.dig("tool_input", "file_path").to_s' 2>/dev/null) || exit 0
if [[ -z "$file_path" || "$file_path" != *.cs || ! -f "$file_path" ]]; then
  exit 0
fi
root="${CLAUDE_PROJECT_DIR:-.}"
if command -v dotnet &>/dev/null && [ -n "$(find "$root" -maxdepth 1 -name '*.sln' 2>/dev/null | head -1)" ]; then
  (cd "$root" && dotnet format --include "$file_path" --verbosity quiet 2>/dev/null) || true
fi
exit 0
