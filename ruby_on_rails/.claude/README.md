# Claude Code Configuration for Ruby on Rails

This directory is a Claude Code configuration template based on the Ruby Style Guide, Rails Style Guide, RSpec Style Guide, and Rails Guides. Copy it along with `CLAUDE.md` to the root of a Rails project to use it.

## Prerequisites

- **Ruby** 3.1+
- **Rails** 7.0+ (Hotwire rules assume Rails 7+ with Turbo/Stimulus)
- **RuboCop** (optional but recommended): `rubocop`, `rubocop-rails`, `rubocop-rspec` in `Gemfile`
- **Brakeman** (optional): for the `/run-brakeman` security scan command
- **bundler-audit** (optional): for the `/run-bundler-audit` dependency vulnerability scan
- **RSpec** or **Minitest**: rules support both; RSpec-specific rules apply only to `*_spec.rb` files

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, style rules, workflows, code review guidelines |
| **.claude/agents/** | Custom sub-agents (test runner, code reviewer) |
| **.claude/skills/** | Skills for Rails development, RSpec, and refactoring (auto-loaded by Claude when relevant) |
| **.claude/commands/** | Slash commands run from chat with `/` |
| **.claude/hooks/** | Hook scripts (e.g. RuboCop after file edit) |
| **.claude/settings.json** | Hook configuration |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your Rails app root.
   ```bash
   cp ruby_on_rails/CLAUDE.md /path/to/your/rails_app/CLAUDE.md
   cp -r ruby_on_rails/.claude /path/to/your/rails_app/.claude
   ```
2. Make the hook script executable.
   ```bash
   chmod +x .claude/hooks/format-ruby.sh
   ```
3. Open the project with Claude Code. Commands, skills, and agents load automatically. Use `/` to see available commands.

## Commands

Slash commands triggered manually with `/` in chat.

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/run-tests` | Run tests and fix failures (RSpec or Minitest) | `rails-tester` |
| `/code-review-rails` | Review Rails code for style, security, and maintainability | `rails-code-reviewer` |
| `/generate-migration` | Generate and edit a Rails migration | — |
| `/run-rubocop` | Run RuboCop and fix offenses | — |
| `/run-brakeman` | Run Brakeman security scan and review warnings | — |
| `/run-bundler-audit` | Scan gem dependencies for known vulnerabilities | — |

Commands with a sub-agent run in a forked context (`context: fork`) for isolation. Commands without a sub-agent use `disable-model-invocation: true` so Claude does not auto-trigger them.

## Sub-agents

Custom sub-agents that Claude delegates to automatically based on task description, or explicitly via commands.

| Agent | Description | Tools | Model |
|-------|-------------|-------|-------|
| **rails-tester** | Runs test suites, identifies failures, and fixes code or specs | Read, Edit, Write, Bash, Grep, Glob | sonnet |
| **rails-code-reviewer** | Reviews code for style, conventions, security, maintainability | Read, Grep, Glob, Bash | sonnet |

Sub-agent files are in `.claude/agents/`. See [Sub-agents documentation](https://code.claude.com/docs/sub-agents).

## Skills

Background knowledge that Claude auto-loads when working on relevant tasks. These are not user-invocable (`user-invocable: false`); Claude loads them automatically based on context.

| Skill | Auto-loaded when |
|-------|-----------------|
| **rails-development** | Adding or modifying routes, controllers, models, migrations, views |
| **rails-refactor** | Simplifying controllers, extracting services, applying style rules |
| **rspec-testing** | Writing or editing `*_spec.rb` files |

Skill files are in `.claude/skills/<name>/SKILL.md`. See [Skills documentation](https://code.claude.com/docs/skills).

## Hooks

| Event | Matcher | Script | Description |
|-------|---------|--------|-------------|
| PostToolUse | `Edit\|Write` | `format-ruby.sh` | Runs `rubocop -a` on `.rb` files after edit/write. Does nothing if RuboCop is not installed. |

Hook configuration is in `.claude/settings.json`. The hook script receives JSON on stdin with `tool_input.file_path`. See [Hooks documentation](https://code.claude.com/docs/hooks-guide).

## CLAUDE.md Contents

The `CLAUDE.md` file consolidates all project instructions:

- **Principles**: Convention over Configuration, DRY, Fat Model / Skinny Controller
- **Directory layout**: Standard Rails app structure
- **Style rules**: Ruby, Rails, RSpec, ERB, Hotwire (Turbo + Stimulus)
- **Workflows**: Rails Development, Rails Refactor, RSpec Testing
- **Code Review Guidelines**: Checklist with Critical / Warning / Suggestion categories

## Comparison with Cursor Configuration

| Cursor concept | Claude Code equivalent |
|----------------|----------------------|
| Rules (`.mdc` files) | `CLAUDE.md` (consolidated) |
| Commands | `.claude/commands/*.md` (with YAML frontmatter) |
| Agents | `.claude/agents/*.md` (custom sub-agents) |
| Skills | `.claude/skills/<name>/SKILL.md` |
| Hooks (`hooks.json` + scripts) | `.claude/settings.json` + `.claude/hooks/` |
