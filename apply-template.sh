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
AVAILABLE_TEMPLATES="elixir general phoenix python ruby_on_rails rust shellscript typescript unity"

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

# Collect existing files that would be overwritten (directories are excluded)
CONFLICTS=()
while IFS= read -r -d '' path; do
  rel="${path#$SOURCE_DIR/}"
  dest="$TARGET_DIR/$rel"
  if [[ -f "$dest" ]]; then
    CONFLICTS+=("$rel")
  fi
done < <(find "$SOURCE_DIR" -mindepth 1 -type f -print0 2>/dev/null)

# Mergeable files: rel_path, merge_type (concat|jq), jq_expression (for jq only, empty otherwise)
MERGE_REL_PATHS=( "CLAUDE.md" ".claude/settings.json" ".cursor/hooks.json" )
MERGE_TYPES=( "concat" "jq" "jq" )
MERGE_JQ_EXPR=(
  ""
  '($t[0] | .hooks.PostToolUse = (($t[0].hooks.PostToolUse // []) + ($s[0].hooks.PostToolUse // [])))'
  '($t[0] | .hooks.afterFileEdit = (($t[0].hooks.afterFileEdit // []) + ($s[0].hooks.afterFileEdit // [])))'
)

MERGE_DO=()
for i in "${!MERGE_REL_PATHS[@]}"; do
  rel="${MERGE_REL_PATHS[$i]}"
  if [[ -f "$TARGET_DIR/$rel" ]] && [[ -f "$SOURCE_DIR/$rel" ]]; then
    [[ ${#MERGE_DO[@]} -eq 0 ]] && echo ""
    read -r -p "$rel already exists. Merge with new template? [Y/n]: " reply
    if [[ ! "$reply" =~ ^[nN]$ ]]; then
      MERGE_DO+=("$i")
    fi
  fi
done

# Paths we are merging (for overwrite list exclusion)
MERGE_PATHS_DO=()
for i in "${MERGE_DO[@]}"; do
  MERGE_PATHS_DO+=( "${MERGE_REL_PATHS[$i]}" )
done

# Overwrite confirmation: exclude files we are merging from the list
OVERWRITE_LIST=()
for rel in "${CONFLICTS[@]}"; do
  skip=0
  for m in "${MERGE_PATHS_DO[@]}"; do
    [[ "$rel" == "$m" ]] && { skip=1; break; }
  done
  [[ $skip -eq 1 ]] && continue
  OVERWRITE_LIST+=("$rel")
done

if [[ ${#OVERWRITE_LIST[@]} -gt 0 ]]; then
  echo ""
  echo "The following files already exist:"
  printf '  %s\n' "${OVERWRITE_LIST[@]}"
  echo ""
  read -r -p "Overwrite and apply? [y/N]: " reply
  if [[ ! "$reply" =~ ^[yY]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# Back up existing content when merging (tar will overwrite)
for i in "${MERGE_DO[@]}"; do
  rel="${MERGE_REL_PATHS[$i]}"
  cp "$TARGET_DIR/$rel" "$TMP_DIR/target_merge_$i"
done

echo "Applying: $TEMPLATE_NAME -> $TARGET_DIR"
# Exclude README.md in every directory; this script only applies Cursor/Claude Code config, not project docs
(cd "$SOURCE_DIR" && find . -type f ! -name 'README.md' -print0 | tar cf - --null -T -) | (cd "$TARGET_DIR" && tar xf -)

# Apply merges (concat for CLAUDE.md, jq for JSON)
NEED_JQ=0
for i in "${MERGE_DO[@]}"; do
  [[ "${MERGE_TYPES[$i]}" == "jq" ]] && NEED_JQ=1
done
if [[ $NEED_JQ -eq 1 ]] && ! command -v jq &>/dev/null; then
  echo ""
  echo "Warning: jq is required for merging JSON. Not installed; JSON files were overwritten without merge."
  echo "Install jq and run the script again if you want to merge."
fi

for i in "${MERGE_DO[@]}"; do
  rel="${MERGE_REL_PATHS[$i]}"
  type="${MERGE_TYPES[$i]}"
  if [[ "$type" == "concat" ]]; then
    {
      cat "$TMP_DIR/target_merge_$i"
      echo ""; echo "---"; echo ""; echo "## From template: $TEMPLATE_NAME"; echo ""
      cat "$TARGET_DIR/$rel"
    } > "$TMP_DIR/merged_$i" && mv "$TMP_DIR/merged_$i" "$TARGET_DIR/$rel"
    echo "  Merged $rel"
  elif [[ "$type" == "jq" ]] && command -v jq &>/dev/null; then
    expr="${MERGE_JQ_EXPR[$i]}"
    jq -n --slurpfile t "$TMP_DIR/target_merge_$i" --slurpfile s "$TARGET_DIR/$rel" "$expr" \
      | jq . > "$TMP_DIR/merged_$i" && mv "$TMP_DIR/merged_$i" "$TARGET_DIR/$rel"
    echo "  Merged $rel"
  fi
done

echo "Done."
