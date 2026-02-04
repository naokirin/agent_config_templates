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

- **Style**: Follow [Ruby Style Guide](https://rubystyle.guide), [Rails Style Guide](https://rails.rubystyle.guide), and [RSpec Style Guide](https://rspec.rubystyle.guide).
- **Linter**: Use RuboCop (`rubocop`, `rubocop-rails`, `rubocop-rspec`) to enforce style. Run before committing.
- **Tests**: Follow RSpec conventions when using RSpec; for Minitest use `test/` and the Rails Testing Guide.

## Reference

- [Rails Guides](https://guides.rubyonrails.org) for implementation details.
- [Rails API docs](https://api.rubyonrails.org) for class and method references.

---

## Ruby Style (`**/*.rb`)

- Use two spaces for indentation. Limit line length to 80 characters (up to 120 with team agreement).
- One blank line between methods and classes. No blank line after `end`.
- Space around operators. Space after `{` and before `}` in hash literals.
- Do not terminate statements with `;`. One expression per line.
- Method names: `snake_case`. Classes/modules: `CamelCase`. Constants: `SCREAMING_SNAKE_CASE`.
- Use `:symbol` for symbols. Prefer `key: value` style for hash keys when using symbols.
- Prefer single-quoted strings; use double quotes only when interpolation or `\` is needed.
- Use `&&` / `||` instead of `and` / `or`. No space after `!`.
- Avoid long `&.` chains; consider delegation or explicit nil checks.
- `# frozen_string_literal: true` magic comment: required on Ruby < 3.4 (all strings frozen by default from Ruby 3.4+). On Ruby 3.4+ the comment is optional but harmless.
- Use `%w[]` for word arrays and `%i[]` for symbol arrays instead of literal arrays of strings/symbols.
- Use `do...end` for multi-line blocks; use `{ ... }` for single-line blocks and method chains.
- Group method visibility: place `private` / `protected` once, then list all private/protected methods below. Do not sprinkle `private` before each method.

---

## Rails Style (`app/**/*.rb`, `config/**/*.rb`, `db/**/*.rb`, `routes.rb`)

- **Routing**: Prefer `resources`. Use `member` / `collection` for extra actions. Nest at most one level; use `shallow: true` when deeper. Use `match` only when mapping multiple HTTP verbs to one action.
- **Controllers**: Keep them skinny. Move business logic to models. One method call per action besides find/new. Minimize instance variables. Prefer `render plain:` over `render text:`. Use symbol HTTP status (e.g. `:forbidden`).
- **Models**: Group macros (`has_many`, `validates`, `enum`, etc.) at the top. Prefer `has_many :through` over `has_and_belongs_to_many`. Use hash syntax for `enum` with explicit values. Use new-style validations (`validates :email, presence: true`). Use `create!` / `save!` or check return value for persistence.
- **Queries**: Avoid string interpolation; use placeholders or hash conditions. Use `find` (by id), `find_by` (by attributes), `where` / `where.not` (hash). For large record sets, choose the appropriate batch method: `find_each` for per-record processing, `find_in_batches` for batch-array processing (e.g. bulk API calls), `in_batches` for batch-level SQL operations (e.g. `in_batches.update_all`). Use `pluck` / `pick` / `ids` where appropriate. Use symbol arguments for `order` (e.g. `order(created_at: :desc)`).
- **Migrations**: Prefer `change`. Add `default` and `null: false` for booleans. Use `foreign_key: true` for references. Initialize empty DB with `db:schema:load`.
- **Concerns**: Use `ActiveSupport::Concern` for shared model/controller logic. Keep each concern focused on a single responsibility. Place in `app/models/concerns/` or `app/controllers/concerns/`.
- **Active Job**: Keep `perform` idempotent (safe to retry). Use `retry_on` / `discard_on` for error handling. Prefer keyword arguments for clarity. Set the queue name explicitly (`queue_as`).
- **Action Mailer**: Use the mailer only for building the email; keep business logic outside. Name methods after the notification (e.g. `welcome_email`). Use `deliver_later` over `deliver_now` for non-blocking delivery. Provide both HTML and text templates.
- **I18n**: Use `t()` (or `I18n.t`) and `l()` for all user-facing strings; avoid hard-coded text in views, models, and flash messages. Organize locale files under `config/locales/` by model or feature (e.g. `config/locales/models/user.en.yml`). Use lazy lookup in views (`t('.title')`) where possible.

---

## RSpec Style (`**/*_spec.rb`, `spec/**/*.rb`)

- **Layout**: No blank line immediately after `describe` / `context`. One blank line between sibling blocks. One blank line after `let` / `subject` / `before` / `after`. One blank line around each `it`.
- **Order**: `subject` first, then `let` / `let!`, then `before` / `after`, then nested `describe` / `context`.
- **context**: Use `context` for conditions. Include a matching negative case when relevant. Use `before(:context)` instead of `before(:all)`. Omit scope for `before` / `after` (default is `:example`).
- **let / subject**: Use `let` / `let!` for data shared across examples. Use `subject` for the object under test. Prefer named `subject(:name)`. Prefer `let` over instance variables. Guard `find_by` memoization with `defined?` instead of `||=`.
- **Example**: One expectation per example by default. Use `aggregate_failures` for multiple assertions when it improves readability. Use `shared_examples` / `it_behaves_like` to reduce duplication.
- **FactoryBot** (when used): Define factories in `spec/factories/`. Use `build` / `build_stubbed` over `create` when persistence is not needed. Use traits for variations. Avoid deeply nested associations in factory definitions; compose with explicit overrides in tests.

---

## ERB Style (`**/*.erb`)

- Use two-space indentation for both HTML and ERB tags.
- Keep logic minimal in templates. Move complex conditionals and loops into helpers, partials, or presenters/decorators.
- Prefer partials (`render 'form'`) over duplicating markup. Use locals instead of instance variables in partials.
- Use `<%= link_to ..., path_helper %>` and route/path helpers instead of hard-coded URLs.
- Escape output by default (`<%= %>`). Only use `raw` / `html_safe` when the content is explicitly sanitized.
- Prefer `content_for` / `yield` for layout sections over deeply nested conditionals.
- Use `dom_id` / `dom_class` helpers for HTML id/class attributes tied to ActiveRecord objects.
- Avoid inline `<style>` and `<script>` tags; place styles in stylesheets and JavaScript in dedicated files or Stimulus controllers.

---

## Hotwire Style (`app/javascript/**/*.js`, `**/*.turbo_stream.erb`)

### Turbo

- Prefer Turbo Frames (`<turbo-frame>`) for partial page updates over full-page reloads.
- Use Turbo Streams (`.turbo_stream.erb`) for multi-target updates (append, prepend, replace, remove, update). Keep stream responses focused on the DOM changes needed.
- Set `data-turbo-method` and `data-turbo-confirm` on links/buttons instead of writing custom JavaScript for simple actions.
- Use `turbo_frame_tag` helper with a meaningful `id` (prefer `dom_id`). Set `src` for lazy-loaded frames; use `target: "_top"` to break out of a frame when needed.

### Stimulus

- One controller per concern. Name controllers after behavior, not DOM elements (e.g. `toggle` not `button`).
- Use `data-controller`, `data-action`, `data-*-target` attributes in HTML. Keep controller JS files under `app/javascript/controllers/`.
- Prefer Stimulus values and targets over querying the DOM directly. Use `connect()` / `disconnect()` lifecycle callbacks for setup and teardown.
- Avoid putting business logic in Stimulus controllers; they should orchestrate DOM behavior only.

### General

- Minimize custom JavaScript. Favor Turbo + Stimulus over heavy JS frameworks for standard CRUD and navigation.
- Use `broadcast_*` helpers (Turbo Streams over WebSocket) for real-time updates when applicable.

---

## Workflows

### Rails Development

When adding or modifying resources (routes, controllers, models, views), writing or changing migrations, validations, associations, scopes, or implementing API/HTML endpoints:

1. Follow Rails/Ruby style conventions defined above for all generated code.
2. **Routing**: Use `namespace` for admin/API grouping. Run `bin/rails routes` after changes to verify.
3. **Controllers**: Use strong parameters. Prefer `before_action` with lexical scope.
4. **Models**: When adding associations or validations, run the relevant specs or tests immediately.
5. **Migrations**: Do not rely on application-level defaults when the DB can enforce them. Run `bin/rails db:migrate:status` after migration.
6. **Views**: Prefer partials and helpers over inline logic. Use route/path helpers instead of hard-coded URLs.
7. **Quick checks**: `bin/rails routes`, `bin/rails db:migrate:status`, `db:schema:load`, run relevant specs.

### Rails Refactor

When simplifying controllers, models, queries, or specs; extracting services; or applying style rules:

1. **Behavior first**: Refactors must not change observable behavior. Rely on existing tests; add or run specs if coverage is missing.
2. **Incremental**: Prefer small, reviewable steps (e.g. rename, extract method, then move).
3. **Conventions**: After refactor, code should align with the project style rules above.
4. **Verification**: Run `bundle exec rspec` or `bin/rails test`, then `bundle exec rubocop [path]`. Confirm no new warnings or failures.

### RSpec Testing

When writing or editing model, request, feature, or system specs:

1. Follow RSpec layout and conventions defined above for all spec code.
2. Use request/controller specs to drive status, redirects, and assigns; keep expectations focused and use `context` for different params or auth states.
3. When adding a new model or feature, create the corresponding spec file under `spec/` mirroring the `app/` directory structure.
4. Run `bundle exec rspec [path]` to verify after writing or editing specs.

**Spec types reference:**

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

When reviewing Rails code, check against:

- **Ruby style**: indentation, naming, expressions, line length.
- **Rails style**: routing (`resources`/`member`/`collection`), skinny controllers, model macros, association `dependent`, queries (no interpolation; `find`/`find_by`/`where`, `find_each`), migrations.
- **RSpec style** (if specs are in scope): describe/context/let/subject order and layout.
- **ERB style** (if views are in scope): minimal logic in templates, partials with locals, output escaping.
- **Hotwire style** (if Turbo/Stimulus code is in scope): frame/stream usage, Stimulus controller conventions.
- **Security**: strong parameters, no SQL interpolation, auth/authorization where needed.
- **Maintainability**: duplication, clarity, appropriate use of services or form objects.

Categorize feedback as:
- **Critical**: must fix (bugs, security, broken tests).
- **Warning**: should fix (conventions, performance, clarity).
- **Suggestion**: optional improvement.
