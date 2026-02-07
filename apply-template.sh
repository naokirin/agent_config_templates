#!/usr/bin/env bash
#
# agent_config_templates 適用スクリプト
# https://github.com/naokirin/agent_config_templates からテンプレートを取得して適用します。
#
# 使い方:
#   ./apply-template.sh TEMPLATE_NAME [TARGET_DIR]
#
# 例:
#   ./apply-template.sh python              # カレントディレクトリに python テンプレートを適用
#   ./apply-template.sh python ./myproject  # myproject に python テンプレートを適用
#

set -e

REPO_URL="https://github.com/naokirin/agent_config_templates.git"
BRANCH="${BRANCH:-main}"
AVAILABLE_TEMPLATES="elixir phoenix python ruby_on_rails rust shellscript typescript unity"

usage() {
  echo "使い方: $0 TEMPLATE_NAME [TARGET_DIR]"
  echo ""
  echo "  TEMPLATE_NAME  適用するテンプレート名（必須）"
  echo "                 利用可能: $AVAILABLE_TEMPLATES"
  echo "  TARGET_DIR     適用先ディレクトリ（省略時: カレントディレクトリ）"
  echo ""
  echo "例:"
  echo "  $0 python"
  echo "  $0 python ./myproject"
  exit 1
}

# 引数
TEMPLATE_NAME="${1:-}"
TARGET_DIR="${2:-.}"

if [[ -z "$TEMPLATE_NAME" ]]; then
  echo "エラー: TEMPLATE_NAME を指定してください。"
  echo ""
  usage
fi

# テンプレート名の検証
if [[ ! " $AVAILABLE_TEMPLATES " = *" $TEMPLATE_NAME "* ]]; then
  echo "エラー: テンプレート '$TEMPLATE_NAME' は存在しません。"
  echo "利用可能: $AVAILABLE_TEMPLATES"
  exit 1
fi

# 適用先を絶対パスに正規化
if [[ ! -d "$TARGET_DIR" ]]; then
  echo "エラー: 適用先ディレクトリが存在しません: $TARGET_DIR"
  exit 1
fi
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# 一時ディレクトリでリポジトリを取得
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "リポジトリを取得しています: $REPO_URL (branch: $BRANCH)"
if ! git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMP_DIR/repo" 2>/dev/null; then
  # main が無い場合は master を試す
  if [[ "$BRANCH" == "main" ]]; then
    echo "branch main に失敗したため master を試します。"
    git clone --depth 1 --branch master "$REPO_URL" "$TMP_DIR/repo"
  else
    exit 1
  fi
fi

SOURCE_DIR="$TMP_DIR/repo/$TEMPLATE_NAME"
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "エラー: テンプレート '$TEMPLATE_NAME' がリポジトリ内に見つかりません。"
  exit 1
fi

# 上書き対象となる既存のパスを収集（SOURCE_DIR 内の各パスについて TARGET_DIR に存在するか）
CONFLICTS=()
while IFS= read -r -d '' path; do
  rel="${path#$SOURCE_DIR/}"
  dest="$TARGET_DIR/$rel"
  if [[ -e "$dest" ]]; then
    CONFLICTS+=("$rel")
  fi
done < <(find "$SOURCE_DIR" -mindepth 1 -print0 2>/dev/null)

if [[ ${#CONFLICTS[@]} -gt 0 ]]; then
  echo ""
  echo "以下のファイル/ディレクトリが既に存在します:"
  printf '  %s\n' "${CONFLICTS[@]}"
  echo ""
  read -r -p "上書きして適用しますか？ [y/N]: " reply
  if [[ ! "$reply" =~ ^[yY]$ ]]; then
    echo "中止しました。"
    exit 0
  fi
fi

echo "適用中: $TEMPLATE_NAME -> $TARGET_DIR"
# ドットファイル含めすべてコピー（tar でポータブルに実施）
(cd "$SOURCE_DIR" && tar cf - .) | (cd "$TARGET_DIR" && tar xf -)

echo "適用が完了しました。"
