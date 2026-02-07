# Unity / C# AI Agent Configuration Template

This template provides AI agent configuration for Unity projects using C#, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your Unity project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your Unity project root. Commands and skills load automatically.

This repo includes both `.cursor` and `.claude` so you can use either editor; copy only what you need for the editor you use.

## Best practices (built into this template)

- **Verification**: After code changes, run tests (Unity Test Framework) and, when available, `dotnet format`. Use `/run-tests` and `/run-format` so the agent can verify its own work.
- **Style**: Conventions are documented in `.cursor/rules/` (Cursor) or in CLAUDE.md and linked guides (Claude Code). Use EditorConfig or dotnet format where applicable; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
