# Cursor Configuration for Elixir

This directory is a Cursor configuration template for Elixir projects. Copy it to the root of an Elixir project to use it. It is provided alongside a Claude Code configuration (`.claude` + `CLAUDE.md`) in the same repo; use the one that matches your editor.

## Structure

| Path | Description |
|------|-------------|
| **rules/** | Always-applied and glob-based rules (elixir-core, elixir-style, elixir-idioms, exunit-style) |
| **skills/** | Skills for Elixir development, refactoring, and ExUnit testing (auto-loaded when relevant) |
| **commands/** | Slash commands: run-tests-elixir, run-credo-elixir, run-format-elixir, code-review-elixir |
| **agents/** | Agent descriptions for elixir-tester and elixir-code-reviewer |
| **hooks/** | format-elixir.sh runs after editing .ex / .exs files |
| **hooks.json** | Hook configuration (afterFileEdit → format-elixir.sh) |

## Usage

1. Copy `.cursor/` to your Elixir project root.
2. Make the hook executable: `chmod +x .cursor/hooks/format-elixir.sh`
3. Rules, skills, commands, and agents load automatically in Cursor.

## Prerequisites

- **Elixir** and **Mix**: Install via [elixir-lang.org](https://elixir-lang.org/install.html).
- **Credo** (optional): Add to mix.exs deps and run `mix deps.get`; used by `/run-credo-elixir`.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.
