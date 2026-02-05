# Claude Code Configuration for Rust

This directory is a Claude Code configuration template based on Rust idioms, design patterns, anti-patterns, and API guidelines. Copy it along with `CLAUDE.md` to the root of a Rust project to use it.

This template is provided alongside a Cursor configuration (`.cursor`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Rust** (rustc, cargo): Install via [rustup](https://rustup.rs).
- **rustfmt**: Included with rustup; used by the format hook and `/run-rustfmt` command.
- **Clippy** (optional but recommended): `rustup component add clippy`; used by `/run-clippy` command.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.

## Structure

| Directory / file | Description |
|------------------|-------------|
| **CLAUDE.md** | Project instructions: principles, layout, tooling, verification, workflows, code review |
| **.claude/agents/** | Custom sub-agents (tester, code reviewer) |
| **.claude/skills/** | Skills for Rust development, refactoring, and testing (auto-loaded when relevant) |
| **.claude/commands/** | Slash commands run from chat with `/` |
| **.claude/hooks/** | Hook scripts (e.g. rustfmt after file edit) |
| **.claude/settings.json** | Hook configuration |

## Usage

1. Copy `CLAUDE.md` and `.claude/` into your Rust project root.
   ```bash
   cp rust/CLAUDE.md /path/to/your/rust_project/CLAUDE.md
   cp -r rust/.claude /path/to/your/rust_project/.claude
   ```
2. Make the hook script executable.
   ```bash
   chmod +x .claude/hooks/format-rust.sh
   ```
3. Open the project with Claude Code. Commands, skills, and agents load automatically. Use `/` to see available commands.

## Commands

Slash commands triggered manually with `/` in chat.

| Command | Description | Sub-agent |
|---------|-------------|-----------|
| `/run-tests` | Run tests and fix failures | `rust-tester` |
| `/code-review-rust` | Review Rust code for style, safety, and maintainability | `rust-code-reviewer` |
| `/run-clippy` | Run Clippy and fix or document warnings | — |
| `/run-rustfmt` | Format code with rustfmt | — |

Commands with a sub-agent run in a forked context (`context: fork`) for isolation.

## Sub-agents

Custom sub-agents that Claude delegates to automatically based on task description, or explicitly via commands.

| Agent | Description | Tools | Model |
|-------|-------------|-------|-------|
| **rust-tester** | Runs test suites, identifies failures, and fixes code or tests | Read, Edit, Write, Bash, Grep, Glob | sonnet |
| **rust-code-reviewer** | Reviews code for style, idioms, safety, maintainability | Read, Grep, Glob, Bash | sonnet |

Sub-agent files are in `.claude/agents/`. See [Sub-agents documentation](https://code.claude.com/docs/sub-agents).

## Skills

Background knowledge that Claude auto-loads when working on relevant tasks. These are not user-invocable (`user-invocable: false`); Claude loads them automatically based on context.

| Skill | Auto-loaded when |
|-------|-----------------|
| **rust-development** | Writing or modifying Rust code, adding modules, error types, or APIs |
| **rust-refactor** | Simplifying code, improving ownership/borrowing, applying style rules |
| **rust-testing** | Adding or fixing tests (unit, integration, doc tests) |

Skill files are in `.claude/skills/<name>/SKILL.md`. See [Skills documentation](https://code.claude.com/docs/skills).

## Hooks

| Event | Matcher | Script | Description |
|-------|---------|--------|-------------|
| PostToolUse | `Edit\|Write` | `format-rust.sh` | Runs `rustfmt` on `.rs` files after edit/write. Does nothing if rustfmt is not available. |

Hook configuration is in `.claude/settings.json`. The hook script receives JSON on stdin with `tool_input.file_path`. See [Hooks documentation](https://code.claude.com/docs/hooks-guide).

## CLAUDE.md and verification

`CLAUDE.md` is kept short and focuses on principles, directory layout, tooling, **verification** (run `cargo test` and `cargo clippy` after changes), workflows, and code review categories. Detailed style lives in the linked API Guidelines and in `.cursor/rules/` if you use Cursor too. After code changes, the agent should run tests and Clippy to verify; use `/run-tests` and `/run-clippy` when appropriate.

## Comparison with Cursor Configuration

| Cursor concept | Claude Code equivalent |
|----------------|------------------------|
| Rules (`.mdc` files) | `CLAUDE.md` (consolidated) |
| Commands | `.claude/commands/*.md` (with YAML frontmatter) |
| Agents | `.claude/agents/*.md` (custom sub-agents) |
| Skills | `.claude/skills/<name>/SKILL.md` |
| Hooks (`hooks.json` + scripts) | `.claude/settings.json` + `.claude/hooks/` |
