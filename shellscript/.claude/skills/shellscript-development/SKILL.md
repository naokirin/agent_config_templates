---
name: shellscript-development
description: General shell script development following quoting, set -euo pipefail, and ShellCheck best practices. Use when writing or modifying shell scripts, adding functions, or defining scripts.
user-invocable: false
---

# Shell Script Development

## When to Use

- Writing new shell scripts (main scripts, library files, helpers).
- Adding or changing functions and error handling.
- Designing or evolving script interfaces and option parsing.
- Adding or updating usage messages and cleanup (traps).

## Principles

1. **Robustness**: Use `set -euo pipefail` at the top unless you need to allow unset vars or pipe failures; document exceptions. Use `trap` for cleanup where appropriate.
2. **Style**: Follow project rules (CLAUDE.md or `.cursor/rules/` .mdc files). Quote all expansions: `"$var"`, `"$(cmd)"`. Prefer `[[ ]]` in Bash.
3. **Layout**: Keep functions small and single-purpose. Place tests in `tests/` per project convention when using bats or shunit2.

## Verification

- `shellcheck script.sh` or `shellcheck scripts/` when available.
- `shfmt -w -i 2 -ci .` (or project options) when available.
- `bats tests/` or project test command when tests exist.
