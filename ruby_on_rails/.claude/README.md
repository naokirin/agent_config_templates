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
3. Open the project with Claude Code. Commands load automatically. Use `/` to see available commands.

## Commands

| Command | Description |
|---------|-------------|
| `/run-tests` | Run tests and fix failures (RSpec or Minitest) |
| `/generate-migration` | Generate and edit a Rails migration |
| `/code-review-rails` | Review Rails code for style, security, and maintainability |
| `/run-rubocop` | Run RuboCop and fix offenses |
| `/run-brakeman` | Run Brakeman security scan and review warnings |
| `/run-bundler-audit` | Scan gem dependencies for known vulnerabilities |

## Hooks

- **PostToolUse (Edit|Write)**: Runs `format-ruby.sh` after editing or writing `.rb` files. If RuboCop is available via Bundler, runs `rubocop -a` to auto-correct. If RuboCop is not installed, the script does nothing.

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
| Commands | `.claude/commands/*.md` |
| Agents | Commands + CLAUDE.md workflows |
| Skills | CLAUDE.md workflows section |
| Hooks (`hooks.json` + scripts) | `.claude/settings.json` + `.claude/hooks/` |
