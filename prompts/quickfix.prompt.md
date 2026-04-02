---
description: Quick implementation for trivial changes — combines plan, code, and test in one step
agent: Developer
argument-hint: 'Enter task ID (e.g., fix-typo-header)'
---

The **spec_id** is: `${input:spec_id:Task ID e.g. fix-typo-header}`

This is a **quick fix** — combine plan, code, and test in one step.

- Read any existing spec at `.copilot/spec/${input:spec_id}.md` if it exists.
- Create a minimal inline plan (no separate file needed).
- Implement the change with unit tests.
- Run the test suite and report results.
- Log the change to `.copilot/artifact/${input:spec_id}/worklog/`.

**Use this ONLY for changes that are:**
- Under 50 lines of code diff.
- No new API surfaces.
- No architectural decisions.
- No security implications.

If the change is larger or more complex than expected, STOP and suggest using the full `/spec` → `/plan` → `/code` flow instead.
