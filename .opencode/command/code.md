---
description: Implement a feature or bug fix with unit tests
agent: developer
---

The **spec_id** is: `$ARGUMENTS`

**Implement** this feature/fix with unit tests alongside every change.

- Read the spec from `.copilot/spec/$ARGUMENTS.md`.
- Read the plan from `.copilot/artifact/$ARGUMENTS/plan/`.
- Read the research from `.copilot/artifact/$ARGUMENTS/research/` if it exists.
- Follow existing project patterns — don't invent new conventions.
- Run unit tests and linters before presenting. Fix any failures.
- Summarize: files changed, tests written, pass/fail status, deviations from plan.

Follow the Developer agent workflow: gate check, understand the task, implement with unit tests, self-verify, and present.
