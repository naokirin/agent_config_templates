# Cursor Configuration for Phoenix

This directory is a Cursor configuration template for **Phoenix framework** projects. Copy it to the root of your Phoenix project to use it. It is provided alongside a Claude Code configuration (`.claude` + `CLAUDE.md`) in the same repo; use the one that matches your editor.

## Structure

| Path | Description |
|------|-------------|
| **rules/** | Always-applied and glob-based rules (phoenix-core, phoenix-style, ecto-style, liveview-style, exunit-style) |
| **skills/** | Skills for Phoenix development, refactoring, Ecto, LiveView, and ExUnit testing (auto-loaded when relevant) |
| **commands/** | Slash commands: run-tests-phoenix, run-credo-phoenix, run-format-phoenix, code-review-phoenix, generate-context-phoenix |
| **agents/** | Agent descriptions for phoenix-tester and phoenix-code-reviewer |
| **hooks/** | format-elixir.sh runs after editing .ex / .exs files |
| **hooks.json** | Hook configuration (afterFileEdit → format-elixir.sh) |

## Usage

1. Copy `.cursor/` to your Phoenix project root.
2. Make the hook executable: `chmod +x .cursor/hooks/format-elixir.sh`
3. Rules, skills, commands, and agents load automatically in Cursor.

## Prerequisites

- **Elixir**, **Mix**, and **Phoenix**: Install via [elixir-lang.org](https://elixir-lang.org/install.html) and [Phoenix installation guide](https://hexdocs.pm/phoenix/installation.html).
- **Credo** (optional): Add to mix.exs deps and run `mix deps.get`; used by `/run-credo-phoenix`.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.
