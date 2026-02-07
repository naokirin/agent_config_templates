#!/usr/bin/env bash
#
# Apply agent_config_templates from https://github.com/naokirin/agent_config_templates
#
# Usage:
#   ./apply-template.sh TEMPLATE_NAME [TARGET_DIR]
#
# Examples:
#   ./apply-template.sh python              # Apply python template to current directory
#   ./apply-template.sh python ./myproject  # Apply python template to myproject
#

set -e

REPO_URL="https://github.com/naokirin/agent_config_templates.git"
BRANCH="${BRANCH:-main}"
AVAILABLE_TEMPLATES="elixir phoenix python ruby_on_rails rust shellscript typescript unity"

usage() {
  echo "Usage: $0 TEMPLATE_NAME [TARGET_DIR]"
  echo ""
  echo "  TEMPLATE_NAME  Template to apply (required). Available: $AVAILABLE_TEMPLATES"
  echo "  TARGET_DIR     Target directory (default: current directory)"
  echo ""
  echo "Examples:"
  echo "  $0 python"
  echo "  $0 python ./myproject"
  exit 1
}

TEMPLATE_NAME="${1:-}"
TARGET_DIR="${2:-.}"

if [[ -z "$TEMPLATE_NAME" ]]; then
  echo "Error: TEMPLATE_NAME is required."
  echo ""
  usage
fi

if [[ ! " $AVAILABLE_TEMPLATES " = *" $TEMPLATE_NAME "* ]]; then
  echo "Error: Template '$TEMPLATE_NAME' not found."
  echo "Available: $AVAILABLE_TEMPLATES"
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: Target directory does not exist: $TARGET_DIR"
  exit 1
fi
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Fetching repository: $REPO_URL (branch: $BRANCH)"
if ! git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR/repo" 2>/dev/null; then
  if [[ "$BRANCH" == "main" ]]; then
    echo "Branch main failed, trying master."
    git clone --depth 1 --branch master "$REPO_URL" "$TMP_DIR/repo"
  else
    exit 1
  fi
fi

SOURCE_DIR="$TMP_DIR/repo/$TEMPLATE_NAME"
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: Template '$TEMPLATE_NAME' not found in repository."
  exit 1
fi

# Collect existing paths that would be overwritten
CONFLICTS=()
while IFS= read -r -d '' path; do
  rel="${path#$SOURCE_DIR/}"
  dest="$TARGET_DIR/$rel"
  if [[ -e "$dest" ]]; then
    CONFLICTS+=("$rel")
  fi
done < <(find "$SOURCE_DIR" -mindepth 1 -print0 2>/dev/null)

# Ask about merging first: .claude/settings.json and .cursor/hooks.json
MERGE_SETTINGS=0
MERGE_HOOKS=0
if [[ -f "$TARGET_DIR/.claude/settings.json" ]] && [[ -f "$SOURCE_DIR/.claude/settings.json" ]]; then
  echo ""
  read -r -p ".claude/settings.json already exists. Merge with new template? [Y/n]: " reply
  if [[ ! "$reply" =~ ^[nN]$ ]]; then
    MERGE_SETTINGS=1
  fi
fi
if [[ -f "$TARGET_DIR/.cursor/hooks.json" ]] && [[ -f "$SOURCE_DIR/.cursor/hooks.json" ]]; then
  read -r -p ".cursor/hooks.json already exists. Merge with new template? [Y/n]: " reply
  if [[ ! "$reply" =~ ^[nN]$ ]]; then
    MERGE_HOOKS=1
  fi
fi

# Overwrite confirmation: exclude files we are merging from the list
OVERWRITE_LIST=()
for rel in "${CONFLICTS[@]}"; do
  if [[ $MERGE_SETTINGS -eq 1 && "$rel" == ".claude/settings.json" ]]; then
    continue
  fi
  if [[ $MERGE_HOOKS -eq 1 && "$rel" == ".cursor/hooks.json" ]]; then
    continue
  fi
  OVERWRITE_LIST+=("$rel")
done

if [[ ${#OVERWRITE_LIST[@]} -gt 0 ]]; then
  echo ""
  echo "The following files or directories already exist:"
  printf '  %s\n' "${OVERWRITE_LIST[@]}"
  echo ""
  read -r -p "Overwrite and apply? [y/N]: " reply
  if [[ ! "$reply" =~ ^[yY]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# Back up existing content when merging (tar will overwrite)
if [[ $MERGE_SETTINGS -eq 1 ]]; then
  cp "$TARGET_DIR/.claude/settings.json" "$TMP_DIR/target_settings.json"
fi
if [[ $MERGE_HOOKS -eq 1 ]]; then
  cp "$TARGET_DIR/.cursor/hooks.json" "$TMP_DIR/target_hooks.json"
fi

echo "Applying: $TEMPLATE_NAME -> $TARGET_DIR"
(cd "$SOURCE_DIR" && tar cf - .) | (cd "$TARGET_DIR" && tar xf -)

# Merge with jq when merge was chosen
if [[ $MERGE_SETTINGS -eq 1 ]] || [[ $MERGE_HOOKS -eq 1 ]]; then
  if ! command -v jq &>/dev/null; then
    echo ""
    echo "Warning: jq is required for merging. Not installed; files were overwritten without merge."
    echo "Install jq and run the script again if you want to merge."
  else
    if [[ $MERGE_SETTINGS -eq 1 ]]; then
      jq -n --slurpfile t "$TMP_DIR/target_settings.json" --slurpfile s "$TARGET_DIR/.claude/settings.json" \
        '($t[0] | .hooks.PostToolUse = (($t[0].hooks.PostToolUse // []) + ($s[0].hooks.PostToolUse // [])))' \
        > "$TMP_DIR/merged_settings.json" && mv "$TMP_DIR/merged_settings.json" "$TARGET_DIR/.claude/settings.json"
      echo "  Merged .claude/settings.json"
    fi
    if [[ $MERGE_HOOKS -eq 1 ]]; then
      jq -n --slurpfile t "$TMP_DIR/target_hooks.json" --slurpfile s "$TARGET_DIR/.cursor/hooks.json" \
        '($t[0] | .hooks.afterFileEdit = (($t[0].hooks.afterFileEdit // []) + ($s[0].hooks.afterFileEdit // [])))' \
        > "$TMP_DIR/merged_hooks.json" && mv "$TMP_DIR/merged_hooks.json" "$TARGET_DIR/.cursor/hooks.json"
      echo "  Merged .cursor/hooks.json"
    fi
  fi
fi

echo "Done."
