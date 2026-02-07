# Shell Script Project

## Principles

- **Robustness**: Use `set -euo pipefail` in scripts that should fail on error, unset vars, or pipe failures. Use `set -e` at minimum; document when relaxing (e.g. `set +e` for expected failures).
- **Quoting**: Always quote variables and command substitutions: `"$var"`, `"$(cmd)"`. Prefer `[[ ]]` over `[ ]` in Bash.
- **ShellCheck and formatting**: Follow ShellCheck recommendations; use shfmt when available. Prefer project config (e.g. `.shellcheckrc`, `.editorconfig`) when present.

## Standard Layout

| Path | Purpose |
|------|---------|
| `scripts/` or project root | Main executable scripts (`.sh`) |
| `lib/` or `src/` | Sourced library scripts (optional) |
| `tests/` | Bats or shunit2 tests (optional) |
| `.shellcheckrc` or inline directives | ShellCheck config / overrides |

### Introducing ShellCheck and shfmt

To add lint and format: install `shellcheck` and optionally `shfmt`. Example: `shellcheck script.sh`, `shfmt -w -i 2 -ci script.sh`. The format hook and `/run-lint-shellscript`, `/run-format-shellscript` use these when available. For tests, use [bats-core](https://github.com/bats-core/bats-core) or [shunit2](https://github.com/kward/shunit2).

## Tooling and Style

- **Style**: Follow project rules in `.cursor/rules/` if present (shellscript-core, shellscript-style, shellscript-idioms). Prefer ShellCheck over pasting full style guides.
- **Format**: Use shfmt per project (e.g. `-i 2 -ci` for 2-space indent and indent switch cases). Run before committing; use the format hook when available.
- **Lint**: Use ShellCheck; fix or disable with justification (e.g. `# shellcheck disable=SC2086` and a short comment).
- **Tests**: Use bats or shunit2 when present; keep tests in `tests/` per project convention.

## Verification

After code changes, verify with:

- **Lint**: `shellcheck script.sh` or `shellcheck scripts/`. Use `/run-lint-shellscript` when available.
- **Format**: `shfmt -w -i 2 -ci .` (or project options); use `/run-format-shellscript` when available.
- **Tests**: `bats tests/` or project test command; use `/run-tests-shellscript` when available.

## Reference

- [ShellCheck](https://www.shellcheck.net/)
- [shfmt](https://github.com/mvdan/sh)
- [bats-core](https://github.com/bats-core/bats-core)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html) (optional reference)

---

## Workflows

### Shell Script Development

When writing or modifying shell scripts: follow project style and idiom rules (`.cursor/rules/` or above); quote variables; use `set -euo pipefail` where appropriate; run shellcheck and format after changes.

### Shell Script Refactor

When simplifying scripts or applying style/idiom rules: preserve observable behaviour; rely on existing tests when present; prefer small steps; after refactor run shellcheck and tests and confirm no new failures.

### Testing (bats / shunit2)

When adding or fixing tests: place tests in `tests/` per project convention; use clear test names. Run the test runner to verify.

---

## Code Review Guidelines

When reviewing shell code, check: quoting and `set -euo pipefail`; error handling and exit codes; ShellCheck compliance; portability vs Bash-ism when relevant. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
