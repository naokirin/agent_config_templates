# Agent Configuration Templates

Templates for agents, commands, skills, and rules for Claude Code and Cursor.

## Templates

| Template        | Description |
|-----------------|-------------|
| `general`       | Language-agnostic (rules, agents, /plan, /code-review). Created with reference to generic parts of [everything-claude-code](https://github.com/affaan-m/everything-claude-code). |
| `python`        | Python (pytest, ruff, mypy, etc.) |
| `elixir`        | Elixir (ExUnit, Credo, format, etc.) |
| `phoenix`       | Phoenix (Ecto, LiveView, etc.) |
| `ruby_on_rails` | Ruby on Rails (RSpec, RuboCop, etc.) |
| `rust`          | Rust (clippy, rustfmt, cargo test, etc.) |
| `shellscript`   | Shell script (bats, shellcheck, shfmt) |
| `typescript`    | TypeScript |
| `unity`         | Unity (C#) |

## Applying templates to another repository

Use the script below to fetch and apply a template in any repository.

### 1. Run without saving the script (recommended)

```bash
curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh | sed 's/\r$//' | bash -s -- python .              # Apply python template to current directory
curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh | sed 's/\r$//' | bash -s -- python ./myproject   # Apply python template to myproject
```

`sed 's/\r$//'` strips carriage returns so the script runs correctly even if the file has Windows (CRLF) line endings.

### 2. Clone this repository and run

```bash
git clone https://github.com/naokirin/agent_config_templates.git
cd agent_config_templates
./apply-template.sh python /path/to/your/project
```

### 3. Save the script and run (when you want to inspect it first)

```bash
curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh -o apply-template.sh
chmod +x apply-template.sh
./apply-template.sh python .
# Remove with rm apply-template.sh when no longer needed
```

### Options

- **TEMPLATE_NAME** (required): One of `general`, `python`, `elixir`, `phoenix`, `ruby_on_rails`, `rust`, `shellscript`, `typescript`, `unity`
- **TARGET_DIR** (optional): Target directory; default is the current directory (`.`)

### When files already exist

If files or directories with the same names already exist in the target, the script will prompt before overwriting. Answer `y` to overwrite, or anything else to abort.

### Merging when applying multiple templates (.claude/settings.json and .cursor/hooks.json)

Applying more than one template to the same directory causes these two files to conflict:

- **`.claude/settings.json`** — Claude Code hook settings (e.g. PostToolUse)
- **`.cursor/hooks.json`** — Cursor hook settings (e.g. afterFileEdit)

When these files **already exist** and you run the script, it will ask:

- **Merge with new template? [Y/n]**
  - **Y** (or Enter): **Append** the new template’s settings to the existing ones. Existing hooks are kept and the new template’s hooks are added.
  - **n**: **Overwrite** with the new template’s content.

Merging is done with **jq**. If `jq` is not installed, the script cannot merge and will leave the overwritten content; install `jq` and run the script again to merge.

### Branch

Default branch is `main`. To use another branch:

- When running the one-liner (without saving the script):
  ```bash
  BRANCH=develop bash -c 'curl -sL https://raw.githubusercontent.com/naokirin/agent_config_templates/main/apply-template.sh | sed '\''s/\\r$//'\'' | bash -s -- python .'
  ```
- When cloning the repo and running `apply-template.sh`:
  ```bash
  BRANCH=develop ./apply-template.sh python .
  ```

## Template details

See each template’s README (e.g. `python/README.md`).
