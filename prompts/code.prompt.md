---
description: Implement a feature or bug fix with unit tests
agent: Developer
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

**Implement** this feature/fix with unit tests alongside every change.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Read the plan from `.copilot/artifact/${input:spec_id}/plan/`.
- Read the design from `.copilot/artifact/${input:spec_id}/design/` if it exists.
- Follow existing project patterns — don't invent new conventions.
- Run unit tests and linters before presenting. Fix any failures.
- Summarize: files changed, tests written, pass/fail status, deviations from plan.
