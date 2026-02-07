# Ruby on Rails Project

## Principles

- **Convention over Configuration**: Follow Rails conventions for file placement, naming, and structure. Do not invent custom patterns when Rails provides a standard way.
- **DRY**: Extract shared logic into concerns, helpers, services, or base classes. Avoid copy-pasting code across controllers or models.
- **Fat Model, Skinny Controller**: Keep business logic in models (or service objects); controllers should only coordinate request/response flow.

## Standard Directory Layout

| Directory | Purpose |
|-----------|---------|
| `app/models/` | ActiveRecord models and concerns |
| `app/controllers/` | Request handling; keep actions thin |
| `app/views/` | ERB/HTML templates and partials |
| `app/helpers/` | View helper methods |
| `app/services/` | Service objects for complex business logic |
| `app/jobs/` | Active Job classes for async processing |
| `app/mailers/` | Action Mailer classes |
| `app/channels/` | Action Cable channels for WebSocket |
| `app/javascript/controllers/` | Stimulus controllers (Rails 7+) |
| `config/routes.rb` | Route definitions |
| `db/migrate/` | Database migrations |
| `spec/` or `test/` | Test suite |

## Style and Linting

- **Style**: Follow [Ruby Style Guide](https://rubystyle.guide), [Rails Style Guide](https://rails.rubystyle.guide), and [RSpec Style Guide](https://rspec.rubystyle.guide). When using Cursor, follow the project rules in `.cursor/rules/` (each .mdc). When using Claude Code only, use these guides and any project-specific rules in this file.
- **Linter**: Use RuboCop (`rubocop`, `rubocop-rails`, `rubocop-rspec`) to enforce style. Run before committing.
- **Tests**: Follow RSpec conventions when using RSpec; for Minitest use `test/` and the Rails Testing Guide.

## Verification

After making code changes, verify with:

- **Tests**: Run the relevant tests (`bundle exec rspec [path]` or `bin/rails test`). Prefer single files or scoped paths for speed when appropriate.
- **RuboCop**: Run `bundle exec rubocop [path]` and fix offenses. Use `/run-tests-rails` and `/run-rubocop-rails` (or equivalent commands) to drive verification.

## Reference

- [Rails Guides](https://guides.rubyonrails.org) for implementation details.
- [Rails API docs](https://api.rubyonrails.org) for class and method references.

---

## Workflows

### Rails Development

When adding or modifying resources (routes, controllers, models, views), migrations, validations, associations, or endpoints:

1. Follow project style rules (see Style and Linting above and `.cursor/rules/` if present).
2. **Routing**: Use `namespace` for admin/API. Run `bin/rails routes` after changes.
3. **Controllers**: Use strong parameters. Prefer `before_action` with lexical scope.
4. **Models**: When adding associations or validations, run the relevant specs or tests.
5. **Migrations**: Prefer DB-enforced defaults. Run `bin/rails db:migrate:status` after migration.
6. **Views**: Prefer partials and helpers; use route/path helpers. **Quick checks**: `bin/rails routes`, `bin/rails db:migrate:status`, run relevant specs.

### Rails Refactor

When simplifying code or applying style rules:

1. **Behavior first**: Refactors must not change observable behavior. Rely on existing tests.
2. **Incremental**: Prefer small, reviewable steps.
3. **Verification**: Run tests and `bundle exec rubocop [path]`; confirm no new failures.

### RSpec Testing

When writing or editing specs:

1. Follow project RSpec conventions (see `.cursor/rules/rspec-style.mdc` if present, or [RSpec Style Guide](https://rspec.rubystyle.guide)).
2. Create spec files under `spec/` mirroring `app/` structure. Run `bundle exec rspec [path]` to verify.

| Spec type | Directory | Tests |
|-----------|-----------|-------|
| Model | `spec/models/` | Validations, associations, scopes, methods |
| Request | `spec/requests/` | HTTP status, response body, redirects |
| System/Feature | `spec/system/` | Full browser-driven user flows |
| Helper | `spec/helpers/` | View helper methods |
| Mailer | `spec/mailers/` | Email delivery and content |
| Job | `spec/jobs/` | Active Job behavior |

---

## Code Review Guidelines

When reviewing Rails code, check: Ruby style (indentation, naming); Rails style (routing, skinny controllers, model macros, queries, migrations); RSpec style if specs in scope; ERB/Hotwire if views/JS in scope; security (strong params, no SQL interpolation, auth); maintainability (duplication, services). Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
