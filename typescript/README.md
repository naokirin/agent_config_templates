# TypeScript AI Agent Configuration Template

This template provides AI agent configuration for TypeScript/Node.js projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your TypeScript project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your TypeScript project root. Commands, skills, and agents load automatically; the format hook runs Prettier after editing `.ts` / `.tsx` files.

## Best practices (built into this template)

- **Verification**: After code changes, run typecheck (`npm run typecheck` or `tsc --noEmit`), tests (`npm test`), and lint (`npm run lint`). Use `/run-tests`, `/run-eslint`, and `/run-format` when available so the agent can verify its own work.
- **Style**: Style and idioms are defined in `.cursor/rules/` (Cursor) or in CLAUDE.md and the linked references (Claude Code). Enforce with ESLint and Prettier; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
