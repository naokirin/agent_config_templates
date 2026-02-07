# TypeScript Project

## Principles

- **Strict TypeScript**: Prefer strict mode; avoid `any`; use explicit types for public APIs and boundaries. Let the type system catch errors at compile time.
- **ES Modules**: Use `import`/`export` syntax; prefer destructuring when importing named exports (e.g. `import { foo } from 'bar'`). Do not use `require()` unless integrating with CommonJS.
- **Single Responsibility**: Keep functions and modules focused; prefer small, testable units. Use composition over large classes.

## Standard Layout

| Path | Purpose |
|------|---------|
| `src/` | Application source (`.ts`, `.tsx`) |
| `src/**/*.ts` | TypeScript modules |
| `src/**/*.tsx` | React/JSX components (if applicable) |
| `test/` or `__tests__/` or `*.test.ts` | Unit/integration tests |
| `package.json` | Dependencies and scripts |
| `tsconfig.json` | TypeScript compiler options; recommend `compilerOptions.strict: true` |
| `biome.json` | Biome configuration (linter and formatter) |

### Introducing Biome

To add Biome to a project: install with `npm install -D @biomejs/biome`, then run `npx biome init` to create `biome.json`. Add scripts: `"lint": "biome lint ."`, `"lint:fix": "biome lint --write ."`, `"format": "biome format --write ."`. The format hook and `/run-lint-typescript` / `/run-format-typescript` use these when available.

## Tooling and Style

- **Style**: Follow project rules in `.cursor/rules/` if present (typescript-core, typescript-style, typescript-idioms). Prefer Biome over pasting full style guides into instructions.
- **Format**: Use Biome formatter (project config or default). Run before committing; use the format hook when available.
- **Lint**: Use Biome linter; fix or disable with justification when necessary.
- **Typecheck**: Run `npm run typecheck` or `tsc --noEmit` (or equivalent) after code changes.
- **Tests**: Use Vitest, Jest, or project test runner; keep tests next to code or in a dedicated test directory per project convention.

## Verification

After code changes, verify with:

- **Typecheck**: `npm run typecheck` or `npx tsc --noEmit`. Use `/run-typecheck-typescript` when available.
- **Tests**: `npm test` or `npm run test` (optionally with path or pattern). Use `/run-tests-typescript` when available.
- **Lint**: `npm run lint` or `npx biome lint .` (optionally `--write` to fix); use `/run-lint-typescript` when available.
- **Format**: `npm run format` or `npx biome format --write .`; use `/run-format-typescript` when available.

## Reference

- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
- [Biome](https://biomejs.dev/)
- [Vitest](https://vitest.dev/) / [Jest](https://jestjs.io/)

---

## Workflows

### TypeScript Development

When writing or modifying TypeScript code (modules, types, APIs, components): follow project style and idiom rules (`.cursor/rules/` or above); prefer strict types and ES modules; avoid `any`; run typecheck, tests, and lint after changes.

### TypeScript Refactor

When simplifying code or applying style/idiom rules: preserve observable behaviour; rely on existing tests; prefer small steps; after refactor run typecheck, tests, and lint and confirm no new failures.

### Testing (Vitest / Jest)

When adding or fixing tests: place tests per project convention (`*.test.ts`, `__tests__/`, or `test/`); use `describe` and `it`/`test` with clear descriptions; prefer explicit assertions. Run the test script to verify.

---

## Code Review Guidelines

When reviewing TypeScript code, check: strict typing and no unnecessary `any`; ES module usage and import style; naming (camelCase for variables/functions, PascalCase for types/classes); error handling and async patterns; test coverage and clarity. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
