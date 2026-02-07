# Agent Configuration Templates

Claude / Cursor 向けのエージェント・コマンド・スキル・ルールのテンプレート集です。

## テンプレート一覧

| テンプレート名    | 説明           |
|------------------|----------------|
| `python`         | Python (pytest, ruff, mypy 等) |
| `elixir`         | Elixir (ExUnit, Credo, format 等) |
| `phoenix`        | Phoenix (Ecto, LiveView 等) |
| `ruby_on_rails`  | Ruby on Rails (RSpec, RuboCop 等) |
| `rust`           | Rust (clippy, rustfmt, cargo test 等) |
| `typescript`     | TypeScript     |
| `unity`          | Unity (C#)     |

## 他リポジトリへの適用方法

任意のリポジトリで、このテンプレートを **取得してその場で適用** するには、次のシェルスクリプトを使います。

### 1. スクリプトを取得して実行（推奨）

リポジトリをクローンせず、スクリプトだけ取得して実行する例です。

```bash
# スクリプトをダウンロードして実行（TEMPLATE_NAME と TARGET_DIR を指定）
curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh -o apply-template.sh
chmod +x apply-template.sh
./apply-template.sh python .          # カレントディレクトリに python テンプレートを適用
./apply-template.sh python ./myproject # myproject に python テンプレートを適用
```

### 2. このリポジトリをクローンして実行

```bash
git clone https://github.com/naokirin/agent_config_templates.git
cd agent_config_templates
./apply-template.sh python /path/to/your/project
```

### オプション

- **TEMPLATE_NAME**（必須）: 適用するテンプレート名（`python`, `elixir`, `phoenix`, `ruby_on_rails`, `rust`, `typescript`, `unity` のいずれか）
- **TARGET_DIR**（任意）: 適用先ディレクトリ。省略時はカレントディレクトリ（`.`）

### 既存ファイルがある場合

適用先に同じ名前のファイルやディレクトリが既にある場合、上書きするかどうか確認プロンプトが表示されます。  
`y` で上書き、それ以外で中止します。

### ブランチの指定

デフォルトは `main` です。別ブランチを使う場合:

```bash
BRANCH=develop ./apply-template.sh python .
```

## 各テンプレートの詳細

各テンプレートの README を参照してください（例: `python/README.md`）。
