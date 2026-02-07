# Run Tests and Fix Failures

Run the Rust test suite and fix any failures using the **rust-tester** agent.

- If the user specified a test name, module, or file, run tests for that scope (e.g. `cargo test <filter>`, `cargo test --test integration_name`) and prioritize fixing failures there.
- Otherwise run the full suite: `cargo test`.
- For doc tests only: `cargo test --doc`.
