---
description: Research and evaluate technical options — discovers preferences through focused questions, runs ToT analysis, analyse relevant tools/technologies and recommend set of tools/technologies fitted in architecture along with database models when needed.
agent: Researcher
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

**Research and evaluate** technical options for this feature.

- Read `.copilot/context/constraints.md` for any established preferences.
- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Identify all technical decisions needed for this feature.
- For each decision:
  - If preference exists → use it.
  - If not → **ask me** (one question at a time, with options).
  - If I want evaluation → run full Tree-of-Thought analysis with 3–5 options.
- If the feature requires data persistence → produce a conceptual database model with ERD.
- Update `.copilot/context/constraints.md` with any new decisions I confirm.
- Write output to `.copilot/artifact/${input:spec_id}/research/`.
