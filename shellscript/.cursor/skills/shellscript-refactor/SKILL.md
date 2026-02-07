---
name: shellscript-refactor
description: Refactor shell scripts while preserving behaviour. Use when simplifying scripts, applying style/idiom rules, or improving structure.
user-invocable: false
---

# Shell Script Refactor

## When to Use

- Simplifying or reorganizing existing shell scripts.
- Applying project style and idiom rules (quoting, set options, functions).
- Extracting functions or reducing duplication without changing behaviour.
- Improving error handling and cleanup (traps) in a minimal way.

## Principles

1. **Preserve behaviour**: Do not change observable behaviour (exit codes, stdout/stderr, side effects). Rely on existing tests when present.
2. **Small steps**: Prefer incremental refactors; run shellcheck and tests after each logical step.
3. **Project rules**: Follow CLAUDE.md and `.cursor/rules/` (shellscript-style, shellscript-idioms). Fix or justify ShellCheck overrides.

## Verification

After refactor:

- Run `shellcheck` on modified files and fix or document any new issues.
- Run `bats tests/` or the project test command and confirm no new failures.
- Run `shfmt` if the project uses it; ensure no unintended formatting changes.
