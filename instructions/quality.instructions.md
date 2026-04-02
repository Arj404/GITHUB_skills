---
applyTo: "**/*.{py,ts,js,jsx,tsx,sql,tf}"
---

# Code Quality Standards

## Static Analysis

- Enforce linting in CI as a required check — code MUST NOT be merged with linting errors.
  - Python: `ruff` or `pylint` + `mypy`/`pyright` for type checking.
  - JavaScript/TypeScript: `eslint` + `prettier` + TypeScript strict mode.
  - SQL: `sqlfluff` for linting SQL scripts.
  - Terraform: `tflint` + `checkov` for policy compliance.
- Enable auto-fix in local development (IDE integration) for formatting and import sorting.

## Code Smells to Avoid

- Duplicated code blocks (extract shared logic into functions or modules).
- Functions exceeding ~30 lines or cyclomatic complexity >10.
- Magic numbers and strings (extract into named constants).
- Tight coupling between modules (use dependency injection and interfaces).
- Unused variables, imports, or dead code (remove immediately).
- Deeply nested conditionals (refactor with early returns or guard clauses).

## Refactoring Practices

- Refactor continuously; do not accumulate technical debt without tracking it.
- Extract method, introduce parameter object, and replace conditional with polymorphism as standard refactoring patterns.
- Run the full test suite after every refactoring to confirm behavior preservation.

## Metrics and Thresholds

- Track line coverage (≥80%), branch coverage (≥70%), and cyclomatic complexity (<10 per function).
- Use coverage tools: `pytest-cov` (Python), `istanbul`/`c8` (JS/TS).
- Report metrics in CI and fail the build when thresholds regress.

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [testing](testing.instructions.md) for testing practices and coverage.
