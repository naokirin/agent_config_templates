#!/usr/bin/env bash
# Format edited C# files with dotnet format when available.
# Receives JSON on stdin from Cursor's afterFileEdit hook; extracts file_path and runs dotnet format.
set -euo pipefail
input=$(cat)
file_path=$(printf '%s' "$input" | ruby -rjson -e 'puts JSON.parse(STDIN.read).dig("file_path")' 2>/dev/null) || exit 0
if [[ -z "$file_path" || "$file_path" != *.cs || ! -f "$file_path" ]]; then
  exit 0
fi
root="${CURSOR_PROJECT_DIR:-.}"
# Run dotnet format when solution or project exists (Unity may generate .sln/.csproj)
if command -v dotnet &>/dev/null && [ -n "$(find "$root" -maxdepth 1 -name '*.sln' 2>/dev/null | head -1)" ]; then
  (cd "$root" && dotnet format --include "$file_path" --verbosity quiet 2>/dev/null) || true
fi
exit 0
