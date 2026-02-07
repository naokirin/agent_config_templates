# Run ESLint and Fix Offenses

Run ESLint and fix auto-fixable issues.

1. Check whether the project uses ESLint (eslint.config.*, .eslintrc.*, or eslint in package.json).
2. If the user specified files or directories, run ESLint on that scope; otherwise run on the whole project.
3. Fix auto-fixable offenses with `npx eslint --fix` or `npm run lint -- --fix`; fix others manually.
4. Re-run ESLint to confirm offenses are resolved. Run tests/typecheck if needed.
