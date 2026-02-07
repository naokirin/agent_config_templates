# Shell Script AI Agent Configuration Template

This template provides AI agent configuration for shell script projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your shell script project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your project root. Commands, skills, and agents load automatically; the format hook runs shfmt after editing `.sh` files when available.

## Introducing ShellCheck and shfmt

This template expects [ShellCheck](https://www.shellcheck.net/) for linting and optionally [shfmt](https://github.com/mvdan/sh) for formatting. For tests you can use [bats-core](https://github.com/bats-core/bats-core) or [shunit2](https://github.com/kward/shunit2).

1. **Install** (from the project root):
   ```bash
   # macOS (Homebrew)
   brew install shellcheck shfmt
   # Optional: tests
   brew install bats-core
   ```

2. **Run**:
   - `shellcheck script.sh` or `shellcheck scripts/*.sh`
   - `shfmt -w -i 2 -ci .` (adjust `-i`, `-ci` per project)
   - `bats tests/` when using bats

3. **Optional**: To run the format hook after file edits, ensure shfmt is installed and the hook script is executable (`chmod +x .cursor/hooks/format-shellscript.sh` or `.claude/hooks/format-shellscript.sh`).

## Best practices (built into this template)

- **Verification**: After code changes, run lint (`shellcheck`), format (`shfmt`), and tests when present. Use `/run-lint-shellscript`, `/run-format-shellscript`, and `/run-tests-shellscript` when available so the agent can verify its own work.
- **Style**: Style and idioms are defined in `.cursor/rules/` (Cursor) or in CLAUDE.md (Claude Code). Enforce with ShellCheck; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
