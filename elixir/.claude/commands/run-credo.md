---
description: Run Credo linter and fix or document issues
---

# Run Credo

Run the Credo linter and fix or document any issues.

1. Run `mix credo` (or `mix credo --strict` if the project uses it). If Credo is not in the project, run `mix deps.get` first and retry.
2. For each warning or error: either fix the code to satisfy Credo, or add an allow/disable with a brief comment explaining why.
3. Re-run `mix credo` to confirm no remaining issues. Do not disable checks broadly without justification.
