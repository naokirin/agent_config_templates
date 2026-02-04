---
name: rails-development
description: Implements Rails features following conventions: routing, controllers, models, migrations, and views. Use when adding or changing CRUD, associations, validations, migrations, or request/response flow in a Ruby on Rails app.
---

# Rails Development

## When to Use

- Adding or modifying resources (routes, controllers, models, views).
- Writing or changing migrations, validations, associations, scopes.
- Implementing API or HTML endpoints and form/JSON handling.

## Conventions to Follow

1. **Routing**: Prefer `resources`; use `member`/`collection` for extra actions. Use `namespace` for admin/API. Avoid wild or legacy `match` routes.
2. **Controllers**: Keep actions thin; move logic to models or service objects. Use strong parameters. Prefer `before_action` with lexical scope; minimize instance variables passed to views.
3. **Models**: Group macros at top (associations, validations, enums, callbacks). Use new-style validations. Prefer `has_many :through` over HABTM. Use `find_each` for large sets; avoid raw SQL interpolation.
4. **Migrations**: Use `change`; set `null: false` and `default` for booleans; add `foreign_key: true` for references. Do not rely on application-level defaults when the DB can enforce them.
5. **Views**: Prefer partials and helpers over inline logic. Use route/path helpers instead of hard-coded URLs.

## Quick Checks

- Run `bin/rails routes` when changing routes.
- Run `bin/rails db:migrate:status` and ensure schema is loadable with `db:schema:load` for a fresh DB.
- After changing validations or associations, run the relevant specs or tests.
