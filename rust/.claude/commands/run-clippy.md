---
description: Run Clippy and fix or document warnings
---

# Run Clippy and Fix Warnings

1. Check that the project builds: `cargo build`.
2. Run Clippy:
   - If the user specified files or packages, run on that scope (e.g. `cargo clippy -p crate_name` or on the whole workspace).
   - Otherwise run: `cargo clippy` (or `cargo clippy --all-targets` if desired).
3. Address reported warnings: apply auto-fixes where available (`cargo clippy --fix`), or fix manually. Use `#[allow(...)]` with a short comment only when the lint is a false positive or the deviation is intentional.
4. Re-run Clippy on the same scope to confirm no remaining warnings (or that allowed lints are documented).
5. Run `cargo test` to ensure changes did not break tests.

If the user said "this crate only" or "lib only", run and fix within that scope.
