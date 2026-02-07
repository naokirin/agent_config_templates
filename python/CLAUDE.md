# Python Project

## Principles

- **Type hints**: Use type annotations for public APIs, function parameters, and return types. Prefer `mypy` or `pyright` for static checking; avoid `# type: ignore` unless justified.
- **PEP 8 and tooling**: Follow PEP 8; use Ruff (or Black + Ruff lint) for formatting and linting. Prefer project config in `pyproject.toml`.
- **Single responsibility**: Keep functions and modules focused; prefer small, testable units. Use composition over large classes.

## Standard Layout

| Path | Purpose |
|------|---------|
| `src/` or package name | Application source (`.py`) |
| `tests/` or `test_*.py` | Unit/integration tests (pytest) |
| `pyproject.toml` | Project config, dependencies, tool config (Ruff, mypy/pyright, pytest) |
| `requirements.txt` or `requirements-dev.txt` | Optional; prefer `pyproject.toml` for dependencies when possible |

### Introducing Ruff and type checking

To add Ruff and type checking: add to `pyproject.toml` under `[tool.ruff]` and `[tool.mypy]` (or `[tool.pyright]`). Example scripts: `ruff check .`, `ruff format .`, `pytest`, `mypy src` or `pyright`. The format hook and `/run-lint-python` / `/run-format-python` use these when available.

## Tooling and Style

- **Style**: Follow project rules in `.cursor/rules/` if present (python-core, python-style, python-idioms). Prefer Ruff over pasting full style guides into instructions.
- **Format**: Use Ruff formatter (or Black) per project config. Run before committing; use the format hook when available.
- **Lint**: Use Ruff linter; fix or disable with justification when necessary.
- **Typecheck**: Run `mypy src` or `pyright` (or project script) after code changes.
- **Tests**: Use pytest; keep tests in `tests/` or `test_*.py` per project convention.

## Verification

After code changes, verify with:

- **Typecheck**: `mypy src` or `pyright` (or `python -m pyright`). Use `/run-typecheck-python` when available.
- **Tests**: `pytest` (optionally with path or `-k` pattern). Use `/run-tests-python` when available.
- **Lint**: `ruff check .` (optionally `--fix`); use `/run-lint-python` when available.
- **Format**: `ruff format .` or `black .`; use `/run-format-python` when available.

## Reference

- [PEP 8](https://peps.python.org/pep-0008/)
- [Ruff](https://docs.astral.sh/ruff/)
- [pytest](https://docs.pytest.org/)
- [mypy](https://mypy-lang.org/) / [Pyright](https://microsoft.github.io/pyright/)

---

## Workflows

### Python Development

When writing or modifying Python code (modules, types, APIs): follow project style and idiom rules (`.cursor/rules/` or above); use type hints; run typecheck, tests, and lint after changes.

### Python Refactor

When simplifying code or applying style/idiom rules: preserve observable behaviour; rely on existing tests; prefer small steps; after refactor run typecheck, tests, and lint and confirm no new failures.

### Testing (pytest)

When adding or fixing tests: place tests in `tests/` or `test_*.py` per project convention; use clear test names and `assert` or pytest idioms. Run pytest to verify.

---

## Code Review Guidelines

When reviewing Python code, check: type hints and no unnecessary `Any`; PEP 8 and naming (snake_case); error handling and exceptions; test coverage and clarity. Categorize feedback as **Critical** (must fix), **Warning** (should fix), or **Suggestion** (optional).
