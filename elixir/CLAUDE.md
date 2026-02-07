# Elixir Project

## Principles

- **Idiomatic Elixir**: Prefer pipe `|>`, pattern matching, and immutable data. Use `with` for multi-step success/failure; avoid deep nesting. Keep functions small and single-purpose.
- **OTP and Processes**: Use GenServer, Supervisor, and Application when state or lifecycle matter; prefer pure functions and pipelines where possible. Do not spawn processes unnecessarily.
- **Error Handling**: Return `{:ok, result}` / `{:error, reason}` from public APIs; use `raise` only for truly exceptional cases. Let it crash in supervised trees; handle errors at boundaries.

## Standard Layout

| Path | Purpose |
|------|---------|
| `lib/` | Application and module source (`.ex`) |
| `lib/**/*.ex` | Compiled modules |
| `test/` | ExUnit tests (`.exs`) |
| `mix.exs` | Project manifest (deps, project, aliases) |
| `config/` | Runtime config (optional) |
| `.formatter.exs` | Format options |

## Tooling and Style

- **Style**: Follow [Elixir style guide](https://hexdocs.pm/elixir/style-guide.html) and project rules in `.cursor/rules/` if present (elixir-core, elixir-style, elixir-idioms, exunit-style).
- **Format**: Use `mix format` (default or `.formatter.exs`). Run before committing.
- **Lint**: Use `mix credo` when available; fix or allow with justification.
- **Tests**: `mix test` for unit and integration tests; keep tests in `test/` mirroring `lib/` structure.

## Verification

After code changes, verify with:

- **Tests**: `mix test` (optionally with path or `--only`). Use `/run-tests-elixir` when available.
- **Credo**: `mix credo`; use `/run-credo-elixir` when available.
- **Format**: `mix format` or rely on the format hook if using Cursor.

## Reference

- [Elixir Getting Started](https://elixir-lang.org/getting-started/introduction.html)
- [Elixir Style Guide](https://hexdocs.pm/elixir/style-guide.html)
- [Mix and OTP](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
- [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)

---

## Workflows

### Elixir Development

When writing or modifying Elixir code (modules, functions, APIs, OTP): follow project style and idiom rules (`.cursor/rules/` or above); prefer pipes, pattern matching, and `with`; avoid unnecessary processes; run `mix compile`, `mix test`, and `mix credo` after changes.

### Elixir Refactor

When simplifying code or applying style/idiom rules: preserve observable behaviour; rely on existing tests; prefer small steps; after refactor run `mix test` and `mix credo` and confirm no new failures.

### ExUnit Testing

When adding or fixing tests: place tests in `test/` with `*_test.exs`; use `describe` and `test`; prefer pattern matching in assertions. Run `mix test` to verify.

---

## Code Review Guidelines

When reviewing Elixir code, check: idiomatic Elixir (pipe, pattern match, `with`); naming and module structure; error handling and boundaries; OTP usage (GenServer, Supervisor); test coverage and clarity. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
