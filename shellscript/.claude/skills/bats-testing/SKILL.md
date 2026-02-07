---
name: bats-testing
description: Writing and running tests with bats-core for shell scripts. Use when adding or fixing bats tests.
user-invocable: false
---

# Bats Testing

## When to Use

- Adding or modifying tests for shell scripts using bats-core.
- Debugging failing bats tests or improving test coverage.
- Setting up or documenting the project's test layout (`tests/`, `*.bats`).

## Principles

1. **Layout**: Place test files in `tests/` (e.g. `tests/foo.bats`). Name tests clearly; one logical scenario per `@test` when it improves clarity.
2. **Execution**: Run with `bats tests/` or `bats path/to/test.bats`. Use `run` and assert on `$status` and `$output` as needed.
3. **Isolation**: Prefer testing script behaviour (exit code, output) rather than internal implementation. Use temporary dirs and avoid global state when possible.

## Verification

- Run `bats tests/` (or the relevant test file) after adding or changing tests.
- Ensure the implementation still passes shellcheck when the project uses it.
