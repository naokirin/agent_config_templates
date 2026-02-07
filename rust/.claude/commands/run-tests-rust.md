---
description: Run tests and fix failures (cargo test)
context: fork
agent: rust-tester
argument-hint: "[test name or module]"
---

# Run Tests and Fix Failures

Run the Rust test suite and fix any failures.

## Instructions

1. If the user specified a test name, module, or file, run tests for that scope (e.g. `cargo test <filter>`, `cargo test --test integration_name`) and prioritize fixing failures there.
2. Otherwise run the full suite: `cargo test`. For doc tests only: `cargo test --doc`.
3. Parse the output to identify failing tests; determine whether the failure is in the implementation or the test; apply a minimal fix.
4. Re-run the affected tests to confirm they pass. Keep changes consistent with CLAUDE.md (or `.cursor/rules/`). Do not change behaviour beyond what is needed to fix the failure.

Output a short summary: what failed, what you changed, and that the relevant tests now pass.
