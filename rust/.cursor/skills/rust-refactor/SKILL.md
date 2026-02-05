---
name: rust-refactor
description: Refactors Rust code for clarity and style without changing behaviour. Use when simplifying code, improving ownership/borrowing, or applying style and idiom rules.
---

# Rust Refactor

## When to Use

- Replacing unnecessary clones with borrows, `mem::take`/`replace`, or clearer structure.
- Applying naming, Self, struct population, or import rules from rust-style.mdc.
- Switching to idiomatic patterns (borrowed args, format!, Option/Result handling, constructors).
- Extracting modules or traits, or consolidating error types.

## Principles

1. **Behaviour first**: Refactors must not change observable behaviour. Rely on existing tests; add or run tests if coverage is missing.
2. **Incremental**: Prefer small, reviewable steps (e.g. rename, extract, then move).
3. **Conventions**: After refactor, code should align with rust-core, rust-style, rust-idioms, and rust-anti-patterns.

## Verification

- `cargo test` for the affected area.
- `cargo clippy` (address new lints).
- Confirm no new warnings or test failures.
