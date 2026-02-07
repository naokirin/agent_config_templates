---
description: Run shell script tests (bats or shunit2)
---

# Run Tests (bats / shunit2)

Run the project's shell script test suite.

1. Determine the test runner and layout (e.g. `bats tests/`, `make test`, or shunit2 in `tests/`).
2. If the user specified a file or pattern, run only the relevant tests (e.g. `bats tests/foo.bats`).
3. Parse the output for failures; fix implementation or tests as needed and re-run until the specified scope passes.
4. If no test setup exists, report that and suggest adding bats or shunit2 when appropriate.
