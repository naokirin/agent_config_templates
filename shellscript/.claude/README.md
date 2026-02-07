# Claude Code configuration for shell script projects

- **agents/**  
  - `shellscript-code-reviewer.md`, `shellscript-tester.md`: Code review and test-running agents.
- **commands/**  
  - `/run-lint`, `/run-format`, `/run-tests`, `/code-review-shellscript`: Lint, format, tests, and review.
- **hooks/**  
  - `format-shellscript.sh`: Runs shfmt after editing `.sh` files (PostToolUse; requires shfmt in PATH).
- **skills/**  
  - Shell script development, refactor, and bats-testing skills (see SKILL.md in each directory).
- **settings.json**  
  - PostToolUse hook to run the format script after Edit/Write on files.

Copy `CLAUDE.md` and this `.claude` directory to your shell script project root so Claude Code loads commands, skills, and agents automatically. The format hook runs when shfmt is installed.
