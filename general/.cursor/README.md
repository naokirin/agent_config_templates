# Cursor Configuration (General)

This directory is a **language-agnostic** Cursor configuration template. It provides common rules, agents, commands, and skills that apply to any project. Use it alone for generic repos or combine it with a language-specific template.

Rules are derived from [everything-claude-code](https://github.com/affaan-m/everything-claude-code) common rules (converted to `.mdc`).

## Structure

| Directory / file | Description |
|------------------|-------------|
| **.cursor/rules/** | Always-apply and contextual rules (coding-style, git-workflow, testing, performance, patterns, hooks, agents, security) |
| **.cursor/agents/** | planner, architect, tdd-guide, code-reviewer, security-reviewer, build-error-resolver, e2e-runner, refactor-cleaner, doc-updater |
| **.cursor/commands/** | `/plan`, `/code-review` |
| **.cursor/skills/** | general-workflow |
| **.cursor/hooks.json** | Empty by default; merge with language template for format/lint hooks |

## Rules

| Rule | alwaysApply | Description |
|------|-------------|-------------|
| coding-style.mdc | true | Immutability, file organization, error handling, input validation |
| security.mdc | true | Mandatory security checks, secret management |
| git-workflow.mdc | false | Commit format, PR workflow, feature workflow |
| testing.mdc | false | Coverage, TDD, troubleshooting |
| performance.mdc | false | Model selection, context, extended thinking |
| patterns.mdc | false | Skeleton projects, repository pattern, API envelope |
| hooks.mdc | false | Hook types, TodoWrite |
| agents.mdc | false | When to use planner, code-reviewer |

## Usage

1. Copy `.cursor/` into your project root.
2. Optionally apply a language template; the apply script can merge `hooks.json`.
3. Use `/plan` and `/code-review` in Cursor chat.
