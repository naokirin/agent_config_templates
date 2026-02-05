---
name: elixir-development
description: General Elixir development following idioms, style, and best practices. Use when writing or modifying Elixir code, adding modules, or OTP behaviours.
user-invocable: false
---

# Elixir Development

## When to Use

- Writing new Elixir code (modules, functions, public API).
- Adding or changing OTP behaviours (GenServer, Supervisor, Application).
- Designing or evolving public APIs (structs, callbacks, options).
- Adding dependencies and application config in mix.exs.

## Principles

1. **Idioms**: Prefer pipe `|>`, pattern matching, and `with` for multi-step flows. Return `{:ok, result}` / `{:error, reason}` from public APIs; use `raise` only for exceptional cases.
2. **Style**: Follow the project's Elixir style and idiom rules (CLAUDE.md or `.cursor/rules/` .mdc files). Use snake_case for functions and variables; PascalCase for modules.
3. **OTP**: Use GenServer/Supervisor/Application when state or lifecycle matter; prefer pure functions where possible. Keep callbacks thin; do work in separate functions.
4. **Layout**: One main concern per module; group related functions. Put `@moduledoc` and `@doc` for public APIs. Keep tests in `test/` mirroring `lib/` structure.

## Verification

- `mix compile` and `mix test`.
- `mix credo` when available (fix or allow with justification).
- `mix format` (or rely on the format hook).
