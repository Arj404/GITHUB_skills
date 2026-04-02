---
applyTo: "**"
---

# Code Review Standards

## Pull Request Guidelines

- Every PR MUST have a clear title and description explaining: what changed, why, and how to test.
- Link the PR to the relevant issue, story, or task.
- Keep PRs focused: one logical change per PR (ideally <400 lines of diff).
- Include before/after screenshots for UI changes.
- Add or update tests for every behavioral change.

## Review Process

- At least one peer review is required before merging to `main` or `develop`.
- Reviewers MUST respond within one business day; unblock the team by reviewing promptly.
- Authors MUST respond to all review comments and resolve or explain each one.
- Use "Request Changes" for blocking issues; use "Comment" for suggestions and questions.

## Review Checklist

Reviewers SHOULD verify:

- [ ] **Spec conformance**: implementation fulfills ALL functional requirements from the spec.
- [ ] **Design conformance**: implementation follows architectural decisions from the design doc.
- [ ] **Contract conformance**: if machine-readable contracts exist (OpenAPI, AsyncAPI, JSON Schema in `design/contracts/`), the code conforms to them.
- [ ] Code is readable and self-explanatory; naming is clear.
- [ ] No code duplication; logic is DRY and appropriately abstracted.
- [ ] Error handling is present and meaningful.
- [ ] Security: no hardcoded secrets, input is validated, SQL is parameterized.
- [ ] Tests are included and cover the changed behavior (happy path + edge cases).
- [ ] No breaking changes to public APIs without documentation and migration path.
- [ ] Documentation is updated (README, API docs, inline comments) as needed.
- [ ] Linting and formatting rules are satisfied.
- [ ] Performance: no obvious N+1 queries, unnecessary loops, or memory leaks.
- [ ] Backward compatibility and rollback safety.

## Feedback Tone

- Be constructive and specific; reference standards or examples.
- Prefix suggestions with `nit:` for non-blocking style preferences.
- Praise good patterns and improvements to reinforce positive practices.
- Critique the code, not the author; use "we" language for shared goals.

## Automated Checks

- CI MUST pass (lint, build, test, security scan) before human review begins.
- Auto-assign reviewers using CODEOWNERS where possible.
- Use Copilot code review as a pre-filter; human reviewers focus on logic, design, and intent.

## References

- Follow [coding standards](coding.standard.instructions.md) for what constitutes good code.
- Follow [testing](testing.instructions.md) for test coverage expectations.
- Follow [security](security.instructions.md) for security review criteria.
