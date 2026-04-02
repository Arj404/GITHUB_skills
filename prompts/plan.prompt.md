---
description: Create a detailed, developer-ready implementation plan
agent: Planner
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Create an **implementation plan** for this spec.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Read the design from `.copilot/artifact/${input:spec_id}/design/` if it exists.
- Write the plan to `.copilot/artifact/${input:spec_id}/plan/`.
- Research the codebase before planning — identify files, modules, and interfaces to change.
- Include unit test expectations alongside each step.
- No code blocks — describe changes, link to files and symbols.
- Present the plan as a draft — iterate until I approve.
