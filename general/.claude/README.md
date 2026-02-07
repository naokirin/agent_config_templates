# Claude Code Configuration (General)

This directory is a **language-agnostic** Claude Code configuration template. It provides common rules, agents, commands, and skills that apply to any project. Use it alone for generic repos or combine it with a language-specific template (e.g. python, typescript).

Based on patterns from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) (common rules and agents).

## Prerequisites

- **Git**: For `/code-review` (git diff).
- No language-specific tools required.

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, layout, verification, workflows |
| **.claude/agents/** | Generic sub-agents (planner, code-reviewer) |
| **.claude/skills/** | General workflow skill (auto-loaded when relevant) |
| **.claude/commands/** | Slash commands: `/plan`, `/code-review` |
| **.claude/settings.json** | Hook configuration (empty by default) |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your project root.
2. Optionally apply a language-specific template on top; the apply script can merge `.claude/settings.json` and `.cursor/hooks.json`.
3. Open the project with Claude Code. Use `/` to see available commands.

## Commands

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/plan` | Create implementation plan; wait for confirmation before coding | planner |
| `/code-review` | Review uncommitted changes for security and quality | code-reviewer |

## Sub-agents

| Agent | Description | Tools | Model |
|-------|-------------|-------|-------|
| **planner** | Creates implementation plans for features and refactors | Read, Grep, Glob | opus |
| **architect** | System design, scalability, technical decisions | Read, Grep, Glob | opus |
| **tdd-guide** | Test-driven development; write tests first | Read, Write, Edit, Bash, Grep | opus |
| **code-reviewer** | Reviews code for quality, security, and maintainability | Read, Grep, Glob, Bash | opus |
| **security-reviewer** | OWASP Top 10, secrets, injection, auth | Read, Write, Edit, Bash, Grep, Glob | opus |
| **build-error-resolver** | Fix build/type errors with minimal diffs | Read, Write, Edit, Bash, Grep, Glob | opus |
| **e2e-runner** | E2E tests, flaky handling, artifacts | Read, Write, Edit, Bash, Grep, Glob | opus |
| **refactor-cleaner** | Dead code removal, duplicate consolidation | Read, Write, Edit, Bash, Grep, Glob | opus |
| **doc-updater** | Codemaps, READMEs, docs from codebase | Read, Write, Edit, Bash, Grep, Glob | opus |

## Skills

| Skill | Auto-loaded when |
|-------|------------------|
| **general-workflow** | Feature implementation, refactoring (when no language skill fits) |

## Hooks

No default hooks. Add language-specific hooks by applying a language template (e.g. python, typescript) and choosing to merge settings.
