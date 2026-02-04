---
name: rails-refactor
description: Refactors Rails code for clarity and style without changing behavior. Use when simplifying controllers, models, queries, or specs; extracting services; or applying Ruby/Rails/RSpec style rules.
---

# Rails Refactor

## When to Use

- Simplifying controllers (moving logic to models or services).
- Replacing deprecated or verbose patterns (e.g. old validations, raw SQL, N+1).
- Applying Ruby/Rails/RSpec style (rules in this project).
- Extracting service objects or form objects.

## Principles

1. **Behavior first**: Refactors must not change observable behavior. Rely on existing tests; add or run specs if coverage is missing.
2. **Incremental**: Prefer small, reviewable steps (e.g. rename, extract method, then move).
3. **Conventions**: After refactor, code should align with `ruby-style.mdc`, `rails-style.mdc`, and `rspec-style.mdc` as applicable.

## Common Refactors

- **Controllers**: Move business logic to model or service; reduce instance variables; use strong params and consistent status/symbols.
- **Models**: Replace string interpolation in queries with placeholders or hash conditions; use `find_each`, `pluck`, `pick`, `ids` where appropriate; group macros and use new-style validations.
- **Specs**: Introduce `subject`/`let`, add `context` for branches, replace duplication with `shared_examples`; fix layout to match RSpec style.

## Verification

- Run the relevant test suite (e.g. `bundle exec rspec` or `bin/rails test`).
- Run RuboCop if the project uses it: `bundle exec rubocop [path]`.
