---
description: Run ESLint and fix auto-fixable issues
disable-model-invocation: true
argument-hint: "[file or directory]"
---

# Run ESLint and Fix Offenses

Run ESLint and fix auto-fixable issues: $ARGUMENTS

## Instructions

1. Check whether the project uses ESLint (presence of `eslint.config.*`, `.eslintrc.*`, or `eslint` in package.json dependencies/devDependencies).
2. Determine scope:
   - If the user specified files or directories, run ESLint on that scope (e.g. `npx eslint src/` or `npx eslint path/to/file.ts`).
   - Otherwise run on the whole project (e.g. `npx eslint .` or `npm run lint`).
3. Run ESLint and note the offenses. Fix auto-fixable ones with `npx eslint --fix` (or `npm run lint -- --fix`), or fix manually.
4. Re-run ESLint on the same scope to confirm offenses are resolved.
5. If needed, run the test suite and typecheck to ensure changes did not break anything.

If the user said "this file only" or "src only", run and fix within that scope.
