---
applyTo: "**"
---

# Testing Standards

## Organization

- Place tests in a dedicated top-level directory mirroring the source structure:
  - `test/unit/` — isolated unit tests for individual functions and classes.
  - `test/integration/` — tests for module interactions, database, and API integrations.
  - `test/contract/` — contract tests for API boundaries and service interfaces.
  - `test/e2e/` — end-to-end tests for full user flows (when applicable).
- Name test files to clearly indicate scope: `test_<module>.py`, `<module>.test.ts`, `<module>_test.go`.

## Test Design

- Write tests early during feature development (TDD or test-alongside).
- Each test MUST be isolated and independent; no shared mutable state between tests.
- Follow the Arrange-Act-Assert (AAA) pattern for clarity.
- Test both expected behavior (happy path) and edge cases (boundary values, nulls, errors, empty inputs).
- Use descriptive test names that document the expected behavior (e.g., `test_returns_404_when_user_not_found`).

## Mocking and Isolation

- Mock external dependencies (databases, APIs, file systems) in unit tests.
- Use dependency injection to make components testable without deep mocking.
- Prefer lightweight fakes over complex mocking frameworks when possible.
- Integration tests SHOULD use real dependencies (e.g., test database) in controlled environments.

## Coverage and Quality

- Track and report test coverage; aim for ≥80% line coverage on critical business logic.
- Coverage alone is not sufficient; ensure tests assert meaningful behavior, not just execution.
- All tests MUST pass before merging to the main branch.
- Document how to run the full test suite and individual test categories in the project README.

## Performance Tests

- Include load and stress tests for API endpoints and critical data paths when applicable.
- Define performance baselines and fail CI when regressions exceed thresholds.

## References

- Follow [copilot](copilot.instructions.md) for Copilot behavior rules.
- Follow [quality](quality.instructions.md) for quality metrics and analysis.
