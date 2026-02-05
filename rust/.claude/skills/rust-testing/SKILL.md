---
name: rust-testing
description: Writing and fixing Rust tests (unit, integration, doc tests). Use when adding tests, fixing failing tests, or improving test structure.
user-invocable: false
---

# Rust Testing

## When to Use

- Adding unit tests (`#[cfg(test)]` modules, `#[test]`).
- Adding or fixing integration tests in `tests/`.
- Writing or fixing doc tests (`/// ``` ... ````).
- Debugging failing tests (interpret output, fix implementation or test).

## Principles

1. **Placement**: Unit tests next to code in `#[cfg(test)] mod tests`; integration tests in `tests/*.rs`. One integration binary per file.
2. **Style**: Use descriptive test names; prefer `?` in non-test code. In tests, `.unwrap()` or `.expect("...")` is acceptable for clearer failure location.
3. **Isolation**: Tests should be independent; avoid shared mutable state. Use fixtures or helpers where appropriate.
4. **Coverage**: Cover main paths and important error paths; avoid testing implementation details that constrain refactors.

## Verification

- `cargo test` (optionally with filter or `--doc`).
- Ensure no new failures and that changed behaviour is reflected in tests.
