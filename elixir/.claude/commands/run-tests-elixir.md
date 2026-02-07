---
description: Run tests and fix failures (mix test)
context: fork
agent: elixir-tester
argument-hint: "[path or test name]"
---

# Run Tests and Fix Failures

Run the Elixir test suite and fix any failures.

## Instructions

1. If the user specified a path, file, or tag, run tests for that scope (e.g. `mix test path/to/test_file_test.exs`, `mix test --only integration`) and prioritize fixing failures there.
2. Otherwise run the full suite: `mix test`.
3. Parse the output to identify failing tests; determine whether the failure is in the implementation or the test; apply a minimal fix.
4. Re-run the affected tests to confirm they pass. Keep changes consistent with CLAUDE.md (or `.cursor/rules/`). Do not change behaviour beyond what is needed to fix the failure.

Output a short summary: what failed, what you changed, and that the relevant tests now pass.
