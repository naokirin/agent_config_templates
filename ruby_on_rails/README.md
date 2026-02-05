# Ruby on Rails AI Agent Configuration Template

This template provides AI agent configuration for Ruby on Rails projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your Rails app root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your Rails app root. Commands and skills load automatically.

This repo includes both `.cursor` and `.claude` so you can use either editor; copy only what you need for the editor you use.

## Best practices (built into this template)

- **Verification**: After code changes, run tests (`bundle exec rspec` or `bin/rails test`) and RuboCop (`bundle exec rubocop`). Use `/run-tests` and `/run-rubocop` (or equivalent) so the agent can verify its own work.
- **Style**: Style is enforced by RuboCop; detailed conventions live in `.cursor/rules/` (Cursor) or in CLAUDE.md references and linked style guides (Claude Code). Avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
