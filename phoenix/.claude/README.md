# Claude Code Configuration for Phoenix

This directory is a Claude Code configuration template for **Phoenix framework** projects. Copy it along with `CLAUDE.md` to the root of your Phoenix project to use it.

This template is provided alongside a Cursor configuration (`.cursor`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Elixir**, **Mix**, and **Phoenix**: Install via [elixir-lang.org](https://elixir-lang.org/install.html) and [Phoenix installation guide](https://hexdocs.pm/phoenix/installation.html).
- **Credo** (optional): Add to mix.exs deps and run `mix deps.get`; used by `/run-credo-phoenix` command.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, layout, tooling, verification, workflows, code review |
| **.claude/agents/** | Custom sub-agents (phoenix-tester, phoenix-code-reviewer) |
| **.claude/skills/** | Skills for Phoenix development, refactoring, Ecto, LiveView, and ExUnit testing (auto-loaded when relevant) |
| **.claude/commands/** | Slash commands run from chat with `/` |
| **.claude/hooks/** | Hook scripts (e.g. mix format after file edit) |
| **.claude/settings.json** | Hook configuration |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your Phoenix project root.
   ```bash
   cp phoenix/CLAUDE.md /path/to/your/phoenix_project/CLAUDE.md
   cp -r phoenix/.claude /path/to/your/phoenix_project/.claude
   ```
2. Make the hook script executable.
   ```bash
   chmod +x .claude/hooks/format-elixir.sh
   ```
3. Open the project with Claude Code. Commands, skills, and agents load automatically. Use `/` to see available commands.

## Commands

Slash commands triggered manually with `/` in chat.

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/run-tests-phoenix` | Run tests and fix failures | `phoenix-tester` |
| `/code-review-phoenix` | Review Phoenix code for context boundaries, style, Ecto, LiveView, maintainability | `phoenix-code-reviewer` |
| `/run-credo-phoenix` | Run Credo and fix or document warnings | — |
| `/run-format-phoenix` | Format code with mix format | — |
| `/generate-context-phoenix` | Generate Phoenix context/scaffold with mix phx.gen.* | — |

Commands with a sub-agent run in a forked context (`context: fork`) for isolation.

## Sub-agents

Custom sub-agents that Claude delegates to automatically based on task description, or explicitly via commands.

| Agent | Description | Tools | Model |
|-------|-------------|-------|-------|
| **phoenix-tester** | Runs test suites, identifies failures, and fixes code or tests | Read, Edit, Write, Bash, Grep, Glob | sonnet |
| **phoenix-code-reviewer** | Reviews code for context boundaries, style, Ecto, LiveView, maintainability | Read, Grep, Glob, Bash | sonnet |

Sub-agent files are in `.claude/agents/`. See [Sub-agents documentation](https://code.claude.com/docs/sub-agents).

## Skills

Background knowledge that Claude auto-loads when working on relevant tasks. These are not user-invocable (`user-invocable: false`); Claude loads them automatically based on context.

| Skill | Auto-loaded when |
|-------|-----------------|
| **phoenix-development** | Writing or modifying Phoenix/Elixir code, contexts, controllers, LiveView, Ecto |
| **phoenix-refactor** | Simplifying code, applying context boundaries, improving structure |
| **ecto** | Working with schemas, changesets, queries, migrations |
| **liveview** | Adding or changing LiveView, live components, real-time UI |
| **exunit-testing** | Adding or fixing tests (unit, ConnCase, DataCase, LiveView) |

Skill files are in `.claude/skills/<name>/SKILL.md`. See [Skills documentation](https://code.claude.com/docs/skills).

## Hooks

| Event | Matcher | Script | Description |
|-------|---------|--------|-------------|
| PostToolUse | `Edit\|Write` | `format-elixir.sh` | Runs `mix format` on `.ex`/`.exs` files after edit/write. Does nothing if mix is not available. |

Hook configuration is in `.claude/settings.json`. See [Hooks documentation](https://code.claude.com/docs/hooks-guide).

## CLAUDE.md and verification

`CLAUDE.md` is kept short and focuses on principles, directory layout, **context boundaries**, tooling, **verification** (run `mix test` and `mix credo` after changes), workflows, and code review categories. Detailed style lives in the linked docs and in `.cursor/rules/` if you use Cursor too. After code changes, the agent should run tests and Credo to verify; use `/run-tests-phoenix` and `/run-credo-phoenix` when appropriate.

## Comparison with Cursor Configuration

| Cursor concept | Claude Code equivalent |
|----------------|------------------------|
| Rules (`.mdc` files) | `CLAUDE.md` (consolidated) |
| Commands | `.claude/commands/*.md` (with YAML frontmatter) |
| Agents | `.claude/agents/*.md` (custom sub-agents) |
| Skills | `.claude/skills/<name>/SKILL.md` |
| Hooks (`hooks.json` + scripts) | `.claude/settings.json` + `.claude/hooks/` |
