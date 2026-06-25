---
description: Research and evaluate technical options using ToT analysis
agent: researcher
---

The **spec_id** is: `$ARGUMENTS`

**Research and evaluate** technical options for this feature.

- Read `.copilot/context/constraints.md` for any established preferences.
- Read the spec from `.copilot/spec/$ARGUMENTS.md`.
- Identify all technical decisions needed for this feature.
- For each decision:
  - If preference exists → use it.
  - If not → **ask me** (one question at a time, with options).
  - If I want evaluation → run full Tree-of-Thought analysis with 3–5 options.
- If the feature requires data persistence → produce a conceptual database model with ERD.
- Update `.copilot/context/constraints.md` with any new decisions I confirm.
- Write output to `.copilot/artifact/$ARGUMENTS/research/`.

Follow the Researcher agent workflow: read inputs, preference discovery, ToT analysis, database modeling, update constraints, output recommendation, and ask for approval.
