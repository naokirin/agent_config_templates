# Cursor Configuration for Ruby on Rails

This directory is a Cursor configuration template based on the Ruby Style Guide, Rails Style Guide, RSpec Style Guide, and Rails Guides. Copy it as `.cursor` at the root of a Rails project to use it.

## Prerequisites

- **Ruby** 3.1+
- **Rails** 7.0+ (Hotwire rules assume Rails 7+ with Turbo/Stimulus)
- **RuboCop** (optional but recommended): `rubocop`, `rubocop-rails`, `rubocop-rspec` in `Gemfile`
- **Brakeman** (optional): for the `/run-brakeman` security scan command
- **bundler-audit** (optional): for the `/run-bundler-audit` dependency vulnerability scan
- **RSpec** or **Minitest**: rules and agents support both; RSpec-specific rules apply only to `*_spec.rb` files

## Structure

| Directory / file | Description |
|------------------|-------------|
| **rules/** | Rules applied always or by file pattern (.mdc) |
| **skills/** | Skills for Rails development, RSpec, and refactoring |
| **commands/** | Commands run from chat with `/` (.md) |
| **agents/** | Custom subagents (test runner, code reviewer) |
| **hooks.json** | Hooks (e.g. RuboCop after file edit) |
| **hooks/** | Hook scripts |

## Usage

1. Copy this directory into your Rails app root as `.cursor`.
   ```bash
   cp -r ruby_on_rails/.cursor /path/to/your/rails_app/.cursor
   ```
2. If using the RuboCop hook, make the script executable.
   ```bash
   chmod +x .cursor/hooks/format-ruby.sh
   ```
3. Open the project in Cursor; Rules, Skills, Commands, and Agents load automatically. Use `/` to see commands; agents are invoked when needed.

## Rules

- **rails-core.mdc** (alwaysApply): Project-wide principles, directory layout, style policy, and reference links.
- **ruby-style.mdc**: Ruby style for `**/*.rb`.
- **rails-style.mdc**: Rails conventions for `app/**`, `config/**`, `db/**`, etc.
- **rspec-style.mdc**: RSpec layout and structure for `**/*_spec.rb`, `spec/**`.
- **erb-style.mdc**: ERB template conventions for `**/*.erb`.
- **hotwire-style.mdc**: Turbo and Stimulus conventions for `app/javascript/**`, `**/*.turbo_stream.erb`.

## Commands

- `/run-tests` — Run tests and fix failures (delegates to **rails-tester** agent).
- `/generate-migration` — Guide for generating and editing migrations.
- `/code-review-rails` — Review Rails code for style, security, and maintainability (delegates to **rails-code-reviewer** agent).
- `/run-rubocop` — Run RuboCop and fix offenses (auto or manual).
- `/run-brakeman` — Run Brakeman security scan and review warnings.
- `/run-bundler-audit` — Scan gem dependencies for known vulnerabilities.

## Agents (subagents)

- **rails-tester**: Runs Rails/RSpec test suites, identifies failing examples, and fixes code or specs to make tests pass.
- **rails-code-reviewer**: Reviews code for style, conventions, security, and maintainability using Ruby/Rails/RSpec style guides.

## Hooks

- **afterFileEdit**: Runs `format-ruby.sh` after editing `.rb` files. If RuboCop is available, runs `rubocop -a` to format. If RuboCop is not installed, the script does nothing.
