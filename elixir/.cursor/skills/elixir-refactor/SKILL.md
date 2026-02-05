---
name: elixir-refactor
description: Refactoring Elixir code while preserving behaviour. Use when simplifying code, applying style/idiom rules, or improving structure without changing behaviour.
user-invocable: false
---

# Elixir Refactor

## When to Use

- Simplifying functions or replacing conditionals with pattern matching or `with`.
- Applying style or idiom rules (pipe, naming, module structure).
- Extracting functions or modules to reduce complexity.
- Improving error handling or boundaries without changing observable behaviour.

## Principles

1. **Preserve behaviour**: Do not change inputs/outputs or side effects. Rely on existing tests; run `mix test` after each logical step.
2. **Small steps**: Prefer a sequence of small, testable refactors over one large change. Commit or checkpoint when tests pass.
3. **Idioms**: Prefer pipe where data flows through transformations; use `with` for multi-step success/failure; replace nested `if`/`case` with pattern matching in function heads where appropriate.
4. **Verification**: After refactor, run `mix test` and `mix credo` and confirm no new failures or warnings. Do not suppress Credo without justification.
