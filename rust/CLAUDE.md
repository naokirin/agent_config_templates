# Rust Project

## Principles

- **Idiomatic Rust**: Prefer standard idioms (borrowed types for args, `format!` for strings, constructors, `Default`, `mem::take`/`replace`, pattern matching). Keep code readable for Rust developers.
- **Ownership and Borrowing**: Avoid unnecessary clones to satisfy the borrow checker; prefer `mem::take`/`replace`, restructuring, or `Rc`/`Arc` where appropriate. Do not use `#[deny(warnings)]` at crate root.
- **Error Handling**: Use concrete error types (e.g. `thiserror`) in libraries; convert dependency errors at boundaries. Prefer `?` and `Result` over `.unwrap()` except in tests or tiny scopes with programmer-only failure.

## Standard Layout

| Path | Purpose |
|------|---------|
| `src/lib.rs` | Library root; re-exports, crate-level docs |
| `src/main.rs` | Binary entrypoint |
| `src/**/*.rs` | Modules and submodules |
| `tests/` | Integration tests |
| `benches/` | Benchmarks |
| `Cargo.toml` | Manifest (dependencies, features, profile) |

## Tooling and Style

- **Style**: Follow [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/) and project rules in `.cursor/rules/` if present (rust-style, rust-idioms, rust-anti-patterns).
- **Format**: Use `rustfmt` (default or `rustfmt.toml`). Run before committing.
- **Lint**: Use `cargo clippy`; fix or allow with justification.
- **Tests**: `cargo test` for unit and integration tests; keep tests close to code or in `tests/`.

## Verification

After code changes, verify with:

- **Tests**: `cargo test` (optionally with filter or `--doc`). Use `/run-tests-rust` when available.
- **Clippy**: `cargo clippy`; use `/run-clippy-rust` when available.
- **Format**: `cargo fmt` or rely on the format hook if using Cursor.

## Reference

- [The Rust Book](https://doc.rust-lang.org/book/)
- [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- [Rust by Example](https://doc.rust-lang.org/rust-by-example/)
- [Rust Design Patterns](https://rust-lang.github.io/rust-patterns/)

---

## Workflows

### Rust Development

When writing or modifying Rust code (lib, bin, modules, error types, APIs): follow project style and idiom rules (`.cursor/rules/` or above); prefer borrowed args, `format!`, constructors, `Default`, `mem::take`/`replace`; avoid clone-for-borrow-checker; run `cargo build`, `cargo test`, and `cargo clippy` after changes.

### Rust Refactor

When simplifying code or applying style/idiom rules: preserve observable behaviour; rely on existing tests; prefer small steps; after refactor run `cargo test` and `cargo clippy` and confirm no new failures.

### Rust Testing

When adding or fixing tests: unit tests in `#[cfg(test)] mod tests`; integration tests in `tests/*.rs`; use descriptive names; `.unwrap()` or `.expect()` is acceptable in tests. Run `cargo test` to verify.

---

## Code Review Guidelines

When reviewing Rust code, check: idiomatic Rust and ownership/borrowing; naming (UK spelling, Self, struct population, imports, errors); borrowed args, format!, constructors, Option/Result, mem::take/replace; avoid clone-for-borrow-checker, `#![deny(warnings)]`, and Deref polymorphism; safety (unsafe, bounds, lifetimes); maintainability. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
