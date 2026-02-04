---
name: rspec-testing
description: Writes and refactors RSpec specs following RSpec style guide: describe/context structure, let/subject order, shared examples, and one-expectation-per-example where appropriate. Use when writing or modifying *_spec.rb or spec/** files.
---

# RSpec Testing

## When to Use

- Writing or editing model, request, feature, or system specs.
- Adding or changing `describe`/`context`/`it`/`let`/`subject`/`before`/`after`.

## Structure

1. **Order in each group**: `subject` first, then `let`/`let!`, then `before`/`after`, then nested groups and examples.
2. **Layout**: No blank line right after `describe`/`context`; one blank line between sibling groups; one blank line after `let`/`subject`/`before`/`after`; one blank line around each `it`.
3. **Naming**: Use `context 'when ...'` for conditions; provide a matching negative context where it makes sense.
4. **Data**: Prefer `let`/`let!` over instance variables. Use named `subject(:name)` when the subject is referenced in examples.

## Expectations

- Prefer one expectation per example when it keeps specs clear; use `aggregate_failures` for multiple assertions in one example when that’s more readable.
- Use `shared_examples`/`it_behaves_like` to remove duplication across similar specs.

## Controllers / Requests

- Use request/controller specs to drive status, redirects, and assigns; keep expectations focused and use `context` for different params or auth states.

## Reference

- Follow project rules in `rspec-style.mdc` (RSpec layout and style).
