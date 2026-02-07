# General Project

Language-agnostic guidelines for any repository. Customize with project-specific layout and tooling.

## Principles

- **Immutability**: Prefer new objects over mutating existing ones; avoid hidden side effects.
- **Small units**: Many small files (200–400 lines typical, 800 max); small functions (<50 lines).
- **Error handling**: Handle errors at every level; never swallow errors silently.
- **Input validation**: Validate at system boundaries; never trust external data.
- **Security**: No hardcoded secrets; validate input; use parameterized queries; sanitize output.

## Standard Layout

Adjust to your project:

| Path | Purpose |
|------|---------|
| `src/` or app root | Application source |
| `tests/` or `*_test.*` | Unit/integration tests |
| Config files | Dependencies, lint, format, test (per language) |

## Verification

After code changes:

- Run tests (project’s test command).
- Run lint/format if configured.
- Use `/code-review` to check uncommitted changes for security and quality.

## Workflows

### Planning

For complex features or refactors: use `/plan` to get an implementation plan, then confirm before coding.

### Implementation

1. Plan (for non-trivial work).
2. Write tests first when TDD applies (RED → GREEN → REFACTOR).
3. Implement and verify (tests, lint, typecheck per project).
4. Run `/code-review` before commit.

### Commits

Use conventional commits: `type: short description` (feat, fix, refactor, docs, test, chore, perf, ci).

## Code Review Guidelines

When reviewing code (or using the code-reviewer agent), check: security (no secrets, validation, injection/XSS prevention), size (functions &lt;50 lines, files &lt;800 lines), error handling, tests, and naming. Categorize as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).

## Reference

- [everything-claude-code](https://github.com/affaan-m/everything-claude-code) — common rules and agents (source of this template’s patterns)
