# Cursor Configuration for Rust

This directory is a Cursor configuration template based on Rust idioms, design patterns, anti-patterns, and rust-best-practices (e.g. naming, code, error, and import discipline). Copy it as `.cursor` at the root of a Rust project to use it.

This template is provided alongside a Claude Code configuration (`.claude` + `CLAUDE.md`) in the same repo; use the one that matches your editor. Content is kept in sync where applicable.

## Prerequisites

- **Rust** (rustc, cargo): Install via [rustup](https://rustup.rs).
- **rustfmt**: Included with rustup; used by the format hook and run-rustfmt command.
- **Clippy** (optional but recommended): `rustup component add clippy`; used by the run-clippy command.
- **jq** or **python3** (optional): Used by the format hook to parse JSON. If neither is available, the hook skips formatting.

## Structure

| Directory / file | Description |
|------------------|-------------|
| **rules/** | Rules applied always or by file pattern (`.mdc`) |
| **skills/** | Skills for Rust development, refactoring, and testing |
| **commands/** | Commands run from chat with `/` (`.md`) |
| **agents/** | Custom subagents (tester, code reviewer) |
| **hooks.json** | Hooks (e.g. rustfmt after file edit) |
| **hooks/** | Hook scripts |

## Usage

1. Copy this directory into your Rust project root as `.cursor`.
   ```bash
   cp -r rust/.cursor /path/to/your/rust_project/.cursor
   ```
2. If using the rustfmt hook, make the script executable.
   ```bash
   chmod +x .cursor/hooks/format-rust.sh
   ```
3. Open the project in Cursor; Rules, Skills, Commands, and Agents load automatically. Use `/` to see commands; agents are invoked when needed.

## Rules

- **rust-core.mdc** (alwaysApply): Project-wide principles, directory layout, tooling, and reference links.
- **rust-style.mdc**: Naming, Self, struct/tuple population, mutability, imports, errors, panic policy (for `**/*.rs`).
- **rust-idioms.mdc**: Borrowed arguments, format!, constructors, Default, Option/Result, mem::take/replace, RAII (for `**/*.rs`).
- **rust-anti-patterns.mdc**: Avoid clone-for-borrow-checker, `#![deny(warnings)]`, and Deref polymorphism (for `**/*.rs`).

## Commands

- **/run-tests** — Run tests and fix failures (delegates to **rust-tester** agent).
- **/run-clippy** — Run Clippy and fix or document warnings.
- **/run-rustfmt** — Format code with rustfmt.
- **/code-review-rust** — Review Rust code for style, safety, and maintainability (delegates to **rust-code-reviewer** agent).

## Agents (subagents)

- **rust-tester**: Runs `cargo test`, identifies failing tests, and fixes code or tests to make them pass.
- **rust-code-reviewer**: Reviews code against project rules and Rust best practices; reports Critical / Warning / Suggestion with concrete fixes.

## Hooks

- **afterFileEdit**: Runs `format-rust.sh` after editing `.rs` files. The script uses `jq` (preferred) or `python3` (fallback) to parse JSON input. If `rustfmt` is available, formats the edited file. If any required tool is missing, the script exits successfully and does nothing.

## Verification and style

After code changes, the agent should verify with `cargo test` and `cargo clippy` (see **rust-core** rule). Style and idioms are defined in the `rules/` .mdc files and enforced by rustfmt and Clippy; keep instructions focused on principles and workflow so the agent stays effective.

## Reference

The rules and skills are informed by:

- [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- [Rust Design Patterns](https://rust-lang.github.io/rust-patterns/) (idioms, patterns, anti-patterns)
- [Rust Best Practices](https://rust-lang.github.io/rust-best-practices/) (e.g. Canonical-style discipline for naming, code, errors, imports)
