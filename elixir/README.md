# Elixir AI Agent Configuration Template

This template provides AI agent configuration for Elixir projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your Elixir project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your Elixir project root. Commands, skills, and agents load automatically; the format hook runs `mix format` after editing `.ex` / `.exs` files.

## Best practices (built into this template)

- **Verification**: After code changes, run `mix test` and `mix credo` (and `mix format`). Use `/run-tests` and `/run-credo` when available so the agent can verify its own work.
- **Style**: Style and idioms are defined in `.cursor/rules/` (Cursor) or in CLAUDE.md and the linked style guide (Claude Code). Enforce with `mix format` and Credo; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
