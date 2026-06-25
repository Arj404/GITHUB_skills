---
description: Quick implementation for trivial changes — combines plan, code, and test in one step
agent: developer
---

The **spec_id** is: `$ARGUMENTS`

This is a **quick fix** — combine plan, code, and test in one step.

- Read any existing spec at `.copilot/spec/$ARGUMENTS.md` if it exists.
- Create a minimal inline plan (no separate file needed).
- Implement the change with unit tests.
- Run the test suite and report results.
- Log the change to `.copilot/artifact/$ARGUMENTS/worklog/`.

**Use this ONLY for changes that are:**
- Under 50 lines of code diff.
- No new API surfaces.
- No architectural decisions.
