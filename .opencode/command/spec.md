---
description: Write a structured feature or bug specification
agent: product
---

The **spec_id** is: `$ARGUMENTS`

First, ask me whether this is a **Feature**, **Bug**, or **Spike** (use the question tool with options: Feature, Bug, Spike).

Then write a specification accordingly:

**If Feature:**
- Include YAML frontmatter with: `spec_id`, `type: feature`, `status: draft`, `approved_by:`, `approved_date:`.
- Include: overview, goals, user stories, functional/non-functional requirements, acceptance criteria, out of scope, success metrics.

**If Bug:**
- Include YAML frontmatter with: `spec_id`, `type: bugfix`, `status: draft`, `approved_by:`, `approved_date:`.
- Include: steps to reproduce, expected vs. actual behavior, severity, environment, root cause hypothesis.

**If Spike:**
- Include YAML frontmatter with: `spec_id`, `type: spike`, `status: draft`, `timebox:`, `approved_by:`, `approved_date:`.
- Include: goal, motivation, investigation scope, success criteria, deliverables.

Write the spec to `.copilot/spec/$ARGUMENTS.md`.

Follow the Product agent workflow: discover context, clarify requirements, evaluate scope (split check), write the spec, then ask for approval.
