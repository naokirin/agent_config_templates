# Phoenix Project

## Principles

- **Idiomatic Elixir**: Prefer pipe `|>`, pattern matching, and immutable data. Use `with` for multi-step success/failure; avoid deep nesting. Keep functions small and single-purpose.
- **Phoenix conventions**: Use Contexts to group domain logic; keep Controllers/LiveView thin and delegate to contexts. Prefer `lib/my_app/` for business logic and `lib/my_app_web/` for web-facing code (controllers, live views, components).
- **Ecto**: Use schemas, changesets, and the repo for data; keep queries in context modules or dedicated query modules. Use migrations for schema changes; never edit migration files after they have been run in production.
- **LiveView**: Keep state in assigns; use `send(self(), ...)` for async work; avoid large inline markup—extract to function components or LiveComponents when it helps readability.
- **Error handling**: Return `{:ok, result}` / `{:error, reason}` from context functions; use `raise` only for truly exceptional cases. Handle errors at the controller/LiveView boundary (flash, redirect, or assign).

## Standard Layout

| Path | Purpose |
|------|---------|
| `lib/my_app/` | Contexts, domain logic, Ecto schemas (application name may vary) |
| `lib/my_app_web/` | Controllers, LiveView, components, routers, views |
| `lib/my_app_web.ex` | Web-facing function components and helpers |
| `lib/my_app_web/router.ex` | Routes (pipelines, scopes, live sessions) |
| `test/` | ExUnit tests; `support/` for ConnCase, DataCase, etc. |
| `priv/repo/migrations/` | Ecto migrations (do not modify after running in prod) |
| `mix.exs` | Project manifest (deps, project, aliases) |
| `config/` | Runtime config (config.exs, dev/test/prod) |
| `.formatter.exs` | Format options |

## Tooling and Style

- **Style**: Follow [Elixir style guide](https://hexdocs.pm/elixir/style-guide.html) and project rules in `.cursor/rules/` if present (phoenix-core, phoenix-style, ecto-style, liveview-style, exunit-style).
- **Format**: Use `mix format` (default or `.formatter.exs`). Run before committing.
- **Lint**: Use `mix credo` when available; fix or allow with justification.
- **Tests**: `mix test` for unit and integration tests; use `mix test path/to/file_test.exs` or `mix test --only tag` for scoped runs. Phoenix provides ConnCase, DataCase, and LiveView test helpers in `test/support/`.

## Verification

After code changes, verify with:

- **Tests**: `mix test` (optionally with path or `--only`). Use `/run-tests-phoenix` when available.
- **Credo**: `mix credo`; use `/run-credo-phoenix` when available.
- **Format**: `mix format` or rely on the format hook if using Cursor.
- **Compile**: `mix compile --warnings-as-errors` when you want to treat warnings as failures.

## Reference

- [Phoenix Guides](https://hexdocs.pm/phoenix/overview.html)
- [Ecto](https://hexdocs.pm/ecto/Ecto.html)
- [Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)
- [Elixir Style Guide](https://hexdocs.pm/elixir/style-guide.html)
- [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)

---

## Workflows

### Phoenix Development

When adding or changing web features: follow context boundaries (logic in `lib/my_app/`, web in `lib/my_app_web/`); use `mix phx.gen.*` for scaffolds when appropriate; run `mix compile`, `mix test`, and `mix credo` after changes.

### Ecto / Data Layer

When adding schemas or migrations: create migration with `mix ecto.gen.migration`; define schema and changeset; add context functions; write DataCase tests. Do not edit existing migrations that have been applied.

### LiveView

When adding or changing LiveView: keep mount/update/handle_event thin; delegate to context; use assigns for UI state; add LiveView tests in `test/my_app_web/live/` when applicable.

### ExUnit Testing

When adding or fixing tests: place tests in `test/` with `*_test.exs`; use ConnCase for HTTP, DataCase for repo, LiveView test helpers for live; prefer `describe` and `test` with clear descriptions. Run `mix test` to verify.

---

## Code Review Guidelines

When reviewing Phoenix code, check: context boundaries and thin controllers/LiveViews; idiomatic Elixir (pipe, pattern match, `with`); Ecto usage (changesets, queries, no N+1); LiveView best practices (assigns, async); test coverage and clarity. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
