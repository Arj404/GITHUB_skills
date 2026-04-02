---
applyTo: "**/*.{py,pyi}"
---

# Python Standards

## Style and Structure

- Follow PEP 8 for formatting; enforce with `black` or `ruff format`.
- Use type hints for all function signatures, return types, and complex variables (PEP 484/585).
- Add docstrings (Google or NumPy style) to all public modules, classes, and functions.
- Prefer `dataclasses` or Pydantic models for structured data over plain dicts.

## Patterns

- Use list comprehensions and generator expressions for simple transformations; avoid nested comprehensions.
- Prefer `pathlib.Path` over `os.path` for file system operations.
- Use `contextlib` and context managers for resource management (files, connections, locks).
- Use `async/await` with `asyncio` for I/O-bound concurrency; avoid threads unless CPU-bound.
- Prefer the `logging` module over `print` for application output.

## Dependencies

- Manage dependencies in `requirements.txt` or `pyproject.toml` with pinned versions.
- Use virtual environments (`venv` or `poetry`) for isolation; never install packages globally.
- Import standard library modules first, then third-party, then local — separated by blank lines (enforce with `isort` or `ruff`).

## Testing

- Use `pytest` as the default test framework with `pytest-cov` for coverage.
- Use `pytest-asyncio` for async test cases.
- Place test fixtures in `conftest.py` at the appropriate directory level.

## Linting and Analysis

- Enforce linting with `ruff` or `pylint`.
- Enforce type checking with `mypy` or `pyright` in strict mode.

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [testing](testing.instructions.md) for testing practices.
