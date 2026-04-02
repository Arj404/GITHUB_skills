---
applyTo: "**"
---

# Coding Standards

## Naming

- Use meaningful, descriptive names for all identifiers (variables, functions, classes, files).
- Follow the target language's naming convention (e.g., `snake_case` for Python, `camelCase` for JavaScript).
- Avoid abbreviations unless universally understood (e.g., `id`, `url`, `http`).
- Boolean variables MUST read as predicates (e.g., `is_active`, `hasPermission`).

## Functions and Modules

- Keep functions small and focused on a single task (~20 lines of logic as a guideline).
- Limit function parameters to 3–4; use an options/config object for more.
- Avoid side effects; prefer pure functions where practical.
- Extract repeated logic into reusable utility functions or shared modules.

## Error Handling

- Handle errors explicitly at every boundary (API, database, file I/O, external services).
- Provide actionable, user-friendly error messages; include context for debugging.
- Never swallow exceptions silently; always log or re-raise.
- Use structured error types/codes for programmatic error handling.

## Code Hygiene

- Follow the DRY principle; eliminate code duplication through abstraction.
- Keep code self-explanatory; add comments only for non-obvious logic, business rules, or "why" decisions.
- Maintain consistent formatting and style per project linting configuration.
- Never hardcode secrets, credentials, or environment-specific values in source code.
- Validate and sanitize all external input at the system boundary.

## Version Control

- Write atomic commits with clear, conventional commit messages (e.g., `feat:`, `fix:`, `docs:`, `refactor:`).
- Keep PRs focused and reviewable (ideally under 400 lines of diff).
- Never commit generated files, build artifacts, or secrets.

## References

- Follow [copilot](copilot.instructions.md) for Copilot behavior rules.
- Follow [quality](quality.instructions.md) for quality and analysis standards.
- Follow [security](security.instructions.md) for security baseline.
