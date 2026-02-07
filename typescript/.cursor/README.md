# Cursor Configuration for TypeScript

This directory is a Cursor configuration template for TypeScript/Node.js projects. Copy it to the root of a TypeScript project to use it. It is provided alongside a Claude Code configuration (`.claude` + `CLAUDE.md`) in the same repo; use the one that matches your editor.

## Structure

| Path | Description |
|------|-------------|
| **rules/** | Always-applied and glob-based rules (typescript-core, typescript-style, typescript-idioms, vitest-style) |
| **skills/** | Skills for TypeScript development, refactoring, and testing (auto-loaded when relevant) |
| **commands/** | Slash commands: run-tests, run-lint, run-format, run-typecheck, code-review-typescript |
| **agents/** | Agent descriptions for typescript-tester and typescript-code-reviewer |
| **hooks/** | format-typescript.sh runs after editing .ts / .tsx / .js / .jsx files |
| **hooks.json** | Hook configuration (afterFileEdit → format-typescript.sh) |

## Usage

1. Copy `.cursor/` to your TypeScript project root.
2. Make the hook executable: `chmod +x .cursor/hooks/format-typescript.sh`
3. Rules, skills, commands, and agents load automatically in Cursor.

## Prerequisites

- **Node.js** and **npm** (or pnpm/yarn): Install via [nodejs.org](https://nodejs.org/).
- **TypeScript**: Add as devDependency; ensure `tsconfig.json` exists.
- **Biome** (optional): Add to devDependencies; used by `/run-lint`, `/run-format`, and the format hook. See the repo root **README.md** (section “Introducing Biome”) for install and `npx biome init` steps.
- **Vitest or Jest** (optional): Add test runner to devDependencies; used by `/run-tests`.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.
