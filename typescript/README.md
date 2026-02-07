# TypeScript AI Agent Configuration Template

This template provides AI agent configuration for TypeScript/Node.js projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your TypeScript project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your TypeScript project root. Commands, skills, and agents load automatically; the format hook runs Biome format after editing `.ts` / `.tsx` files.

## Introducing Biome

This template expects [Biome](https://biomejs.dev/) for linting and formatting. To add Biome to your project:

1. **Install** (from the project root):
   ```bash
   npm install -D @biomejs/biome
   ```

2. **Initialize** config and optionally ignore files:
   ```bash
   npx biome init
   ```
   This creates `biome.json`. Edit it as needed (e.g. `linter.rules`, `formatter.indentStyle`).

3. **Add scripts** to `package.json` so the agent and hooks can run lint/format:
   ```json
   {
     "scripts": {
       "lint": "biome lint .",
       "lint:fix": "biome lint --write .",
       "format": "biome format --write ."
     }
   }
   ```

4. **Optional**: To run the format hook after file edits, ensure `@biomejs/biome` is in `devDependencies` and the hook script is executable (`chmod +x .cursor/hooks/format-typescript.sh` or `.claude/hooks/format-typescript.sh`).

## Best practices (built into this template)

- **Verification**: After code changes, run typecheck (`npm run typecheck` or `tsc --noEmit`), tests (`npm test`), and lint (`npm run lint`). Use `/run-tests-typescript`, `/run-lint-typescript`, and `/run-format-typescript` when available so the agent can verify its own work.
- **Style**: Style and idioms are defined in `.cursor/rules/` (Cursor) or in CLAUDE.md and the linked references (Claude Code). Enforce with Biome; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
