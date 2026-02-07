# Python AI Agent Configuration Template

This template provides AI agent configuration for Python projects, for use with **Cursor** and **Claude Code**. Copy the parts that match your editor.

## Quick start

- **Cursor**: Copy the `.cursor` directory to your Python project root. Rules, skills, commands, and agents load automatically.
- **Claude Code**: Copy `CLAUDE.md` and the `.claude` directory to your Python project root. Commands, skills, and agents load automatically; the format hook runs Ruff (or Black) format after editing `.py` files.

## Introducing Ruff and type checking

This template expects [Ruff](https://docs.astral.sh/ruff/) for linting and formatting, and [pytest](https://docs.pytest.org/) for tests. Type checking can use [mypy](https://mypy-lang.org/) or [Pyright](https://microsoft.github.io/pyright/). To add them to your project:

1. **Install** (from the project root, with your preferred env):
   ```bash
   pip install ruff pytest mypy   # or: pip install ruff pytest pyright
   ```
   Or add to `pyproject.toml`:
   ```toml
   [project.optional-dependencies]
   dev = ["ruff", "pytest", "mypy"]
   ```

2. **Configure** in `pyproject.toml`:
   ```toml
   [tool.ruff]
   line-length = 88
   target-version = "py311"

   [tool.ruff.format]
   quote-style = "double"

   [tool.mypy]
   python_version = "3.11"
   strict = true
   ```
   (Or use `[tool.pyright]` if you use Pyright.)

3. **Add scripts** (in README or Makefile, or as package scripts):
   - `ruff check .` / `ruff check --fix .`
   - `ruff format .`
   - `pytest`
   - `mypy src` or `pyright`

4. **Optional**: To run the format hook after file edits, ensure Ruff (or Black) is installed and the hook script is executable (`chmod +x .cursor/hooks/format-python.sh` or `.claude/hooks/format-python.sh`).

## Best practices (built into this template)

- **Verification**: After code changes, run typecheck (`mypy`/`pyright`), tests (`pytest`), and lint (`ruff check`). Use `/run-tests-python`, `/run-lint-python`, and `/run-format-python` when available so the agent can verify its own work.
- **Style**: Style and idioms are defined in `.cursor/rules/` (Cursor) or in CLAUDE.md and the linked references (Claude Code). Enforce with Ruff; avoid pasting full style guides into instructions.
- **Planning**: For large or multi-file changes, use Plan Mode (Cursor) or a plan-first workflow so the agent implements with a clear, approved plan.

See [Cursor agent best practices](https://cursor.com/ja/blog/agent-best-practices) and [Claude Code best practices](https://code.claude.com/docs/en/best-practices) for more.
