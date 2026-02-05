---
description: Format code with rustfmt
---

# Run rustfmt

1. From the project root, run: `cargo fmt` (or `rustfmt` on specific files if the user requested them).
2. If the user asked to check only (no write), run: `cargo fmt -- --check`.
3. Confirm that formatted output matches project style. If `rustfmt.toml` or `.rustfmt.toml` exists, it will be applied automatically.

No further steps required unless the user also asked to fix Clippy or run tests.
