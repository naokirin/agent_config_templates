# Phoenix AI Agent Configuration Template

This template provides AI agent configuration for **Phoenix framework** projects, for use with **Cursor** and **Claude Code**. It extends the Elixir ecosystem with Phoenix-specific conventions (contexts, Ecto, LiveView, routing). Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your Phoenix project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your Phoenix project root. Commands, skills, and agents load automatically; the format hook runs `mix format` after editing `.ex` / `.exs` files.

## Best practices (built into this template)

- **Verification**: After code changes, run `mix test` and `mix credo` (and `mix format`). Use `/run-tests-phoenix` and `/run-credo-phoenix` when available so the agent can verify its own work.
- **Context boundaries**: Keep business logic in contexts (`lib/my_app/`); keep controllers and LiveViews thin and delegate to contexts. Rules and skills reinforce this.
- **Planning**: For large or multi-file changes (e.g. new context, new LiveView flow), use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.
- **Migrations**: Do not modify migration files after they have been run in production; add new migrations for further changes.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
