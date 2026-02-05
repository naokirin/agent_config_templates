---
name: exunit-testing
description: Adding or fixing ExUnit tests. Use when writing tests, fixing failing tests, or improving test structure and coverage.
user-invocable: false
---

# ExUnit Testing

## When to Use

- Adding tests for new or existing modules (unit or integration).
- Fixing failing tests (determine whether the failure is in implementation or test; fix minimally).
- Improving test structure (describe, setup, tags) or readability.

## Principles

1. **Layout**: One test file per module under test: `test/<path>_test.exs` mirroring `lib/<path>.ex`. Use `describe` and `test "description"` with clear descriptions.
2. **Assertions**: Prefer `assert`, `assert_raise`, `refute`. Use pattern matching in assertions when the shape is important (`assert {:ok, x} = ...`). Keep expected values explicit.
3. **Setup**: Use `setup` or `setup_all` for shared context; use `@tag` for expensive or integration tests; run with `mix test --only tag` when needed.
4. **Verification**: Run `mix test` (optionally with path or filter, e.g. `mix test test/my_module_test.exs`) to verify. Do not change behaviour beyond what is needed to fix the failure.
