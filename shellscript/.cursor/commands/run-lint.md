---
description: Run ShellCheck linter on shell scripts
---

# Run Lint (ShellCheck)

Run ShellCheck on shell scripts and fix or document issues.

1. Check whether the project uses ShellCheck (e.g. `.shellcheckrc` or inline directives).
2. If the user specified files or directories, run ShellCheck on that scope; otherwise run on the whole project (e.g. `scripts/` or `*.sh`).
3. Fix auto-fixable or straightforward issues; for others add `# shellcheck disable=SCxxxx` with a short justification comment when appropriate.
4. Re-run ShellCheck to confirm issues are resolved. Run tests if present and relevant.
