# Claude Code Configuration for TypeScript

This directory is a Claude Code configuration template for TypeScript/Node.js projects. Copy it along with `CLAUDE.md` to the root of a TypeScript project to use it.

This template is provided alongside a Cursor configuration (`.cursor`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Node.js** and **npm** (or pnpm/yarn): Install via [nodejs.org](https://nodejs.org/).
- **TypeScript**: Add as devDependency; ensure `tsconfig.json` exists.
- **ESLint** (optional): Add to devDependencies and config; used by `/run-eslint` command.
- **Prettier** (optional): Add to devDependencies; used by the format hook and `/run-format`.
- **Vitest or Jest** (optional): Add test runner to devDependencies; used by `/run-tests`.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, layout, tooling, verification, workflows, code review |
| **.claude/agents/** | Custom sub-agents (typescript-tester, typescript-code-reviewer) |
| **.claude/skills/** | Skills for TypeScript development, refactoring, and testing (auto-loaded when relevant) |
| **.claude/commands/** | Slash commands run from chat with `/` |
| **.claude/hooks/** | Hook scripts (e.g. Prettier after file edit) |
| **.claude/settings.json** | Hook configuration |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your TypeScript project root.
   ```bash
   cp typescript/CLAUDE.md /path/to/your/ts_project/CLAUDE.md
   cp -r typescript/.claude /path/to/your/ts_project/.claude
   ```
2. Make the hook script executable.
   ```bash
   chmod +x .claude/hooks/format-typescript.sh
   ```
3. Open the project with Claude Code. Commands, skills, and agents load automatically. Use `/` to see available commands.

## Commands

Slash commands triggered manually with `/` in chat.

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/run-tests` | Run tests and fix failures | `typescript-tester` |
| `/code-review-typescript` | Review TypeScript code for style, types, and maintainability | `typescript-code-reviewer` |
| `/run-eslint` | Run ESLint and fix auto-fixable issues | — |
| `/run-format` | Format code with Prettier | — |
| `/run-typecheck` | Run TypeScript type checker | — |

Commands with a sub-agent run in a forked context (`context: fork`) for isolation.

## Sub-agents

Custom sub-agents that Claude delegates to automatically based on task description, or explicitly via commands.

| Agent | Description | Tools | Model |
|-------|-------------|-------|-------|
| **typescript-tester** | Runs test suites, identifies failures, and fixes code or tests | Read, Edit, Write, Bash, Grep, Glob | sonnet |
| **typescript-code-reviewer** | Reviews code for types, style, idioms, and maintainability | Read, Grep, Glob, Bash | sonnet |

Sub-agent files are in `.claude/agents/`. See [Sub-agents documentation](https://code.claude.com/docs/sub-agents).

## Skills

Background knowledge that Claude auto-loads when working on relevant tasks. These are not user-invocable (`user-invocable: false`); Claude loads them automatically based on context.

| Skill | Auto-loaded when |
|-------|-----------------|
| **typescript-development** | Writing or modifying TypeScript code, adding modules, types, APIs |
| **typescript-refactor** | Simplifying code, applying style/idiom rules, improving types |
| **vitest-testing** | Adding or fixing tests (unit, integration) |

Skill files are in `.claude/skills/<name>/SKILL.md`. See [Skills documentation](https://code.claude.com/docs/skills).

## Hooks

| Event | Matcher | Script | Description |
|-------|---------|--------|-------------|
| PostToolUse | `Edit\|Write` | `format-typescript.sh` | Runs Prettier on `.ts`/`.tsx`/`.js`/`.jsx` files after edit/write. No-op if Prettier or npx is not available. |

Hook configuration is in `.claude/settings.json`. See [Hooks documentation](https://code.claude.com/docs/hooks-guide).

## CLAUDE.md and verification

`CLAUDE.md` is kept short and focuses on principles, directory layout, tooling, **verification** (run typecheck, tests, and lint after changes), workflows, and code review categories. Detailed style lives in the linked references and in `.cursor/rules/` if you use Cursor too. After code changes, the agent should run typecheck, tests, and lint to verify; use `/run-typecheck`, `/run-tests`, and `/run-eslint` when appropriate.

## Comparison with Cursor Configuration

| Cursor concept | Claude Code equivalent |
|----------------|------------------------|
| Rules (`.mdc` files) | `CLAUDE.md` (consolidated) |
| Commands | `.claude/commands/*.md` (with YAML frontmatter) |
| Agents | `.claude/agents/*.md` (custom sub-agents) |
| Skills | `.claude/skills/<name>/SKILL.md` |
| Hooks (`hooks.json` + scripts) | `.claude/settings.json` + `.claude/hooks/` |
