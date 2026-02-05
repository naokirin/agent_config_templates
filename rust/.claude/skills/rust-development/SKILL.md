---
name: rust-development
description: General Rust development following idioms, style, and best practices. Use when writing or modifying Rust code, adding modules, error types, or APIs.
user-invocable: false
---

# Rust Development

## When to Use

- Writing new Rust code (lib, bin, modules).
- Adding or changing error types and propagation.
- Designing or evolving public APIs (constructors, builders, traits).
- Adding dependencies and features in Cargo.toml.

## Principles

1. **Idioms**: Prefer borrowed types for arguments (`&str`, `&[T]`), `format!` for strings, associated constructors, `Default`, `mem::take`/`replace` where appropriate. Use `?` and concrete `Result`/error types; avoid `.unwrap()` in production except in tiny, programmer-only-failure scopes.
2. **Style**: Follow the project's Rust style and idiom rules (CLAUDE.md or `.cursor/rules/` .mdc files). Use UK spelling for names.
3. **Ownership**: Avoid cloning only to satisfy the borrow checker; restructure or use `Rc`/`Arc` when shared ownership is intended. Run `cargo clippy` to catch unnecessary clones and other issues.
4. **Layout**: Group imports (std, third-party, crate). Keep modules focused; use `pub(crate)` for internal API.

## Verification

- `cargo build` and `cargo test`.
- `cargo clippy` (fix or allow with justification).
- `rustfmt` (or rely on the format hook).
