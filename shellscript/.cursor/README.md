# Cursor configuration for shell script projects

- **rules/**  
  - `shellscript-core.mdc`: Project layout, tooling, verification (always applied).
  - `shellscript-style.mdc`, `shellscript-idioms.mdc`: Style and idioms (applied for `**/*.sh`).
- **agents/**  
  - `shellscript-code-reviewer.md`, `shellscript-tester.md`: Code review and test-running agents.
- **commands/**  
  - `/run-lint`, `/run-format`, `/run-tests`, `/code-review-shellscript`: Lint, format, tests, and review.
- **hooks/**  
  - `format-shellscript.sh`: Runs shfmt after editing `.sh` files (when shfmt is installed).
- **skills/**  
  - Shell script development and refactor skills (see SKILL.md in each directory).

Copy this `.cursor` directory to your shell script project root so Cursor loads rules, commands, agents, and skills automatically.
