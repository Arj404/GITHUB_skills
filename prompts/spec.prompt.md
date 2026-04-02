---
description: Write a structured feature or bug specification
agent: Product
argument-hint: 'Enter spec ID (e.g., user-auth for features, BUG-1234 for bugs)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth or BUG-1234}`

First, ask me whether this is a **Feature**, **Bug**, or **Spike** (use askQuestions with options: Feature, Bug, Spike).

Then write a specification accordingly:

**If Feature:**
- Include YAML frontmatter with: `spec_id`, `type: feature`, `status: draft`, `approved_by:`, `approved_date:`.
- Include: overview, goals, user stories, functional/non-functional requirements, acceptance criteria, out of scope, success metrics.

**If Bug:**
- Include YAML frontmatter with: `spec_id`, `type: bugfix`, `status: draft`, `approved_by:`, `approved_date:`.
- Include: steps to reproduce, expected vs. actual behavior, severity, environment, root cause hypothesis.

**If Spike (Research):**
- Include YAML frontmatter with: `spec_id`, `type: spike`, `status: draft`, `approved_by:`, `approved_date:`.
- Include: research objective, research questions, scope and assumptions, timebox (e.g., 1 week), success criteria (what outcome will make the spike successful), deliverables (documents, prototypes, notes), recommended approach or tasks, dependencies and known risks, and acceptance criteria for the spike (e.g., decision made or recommended path documented).

**Scope check — 1 file = 1 story/bug/spike:**
- After clarifying requirements, evaluate whether the input describes a single focused story/bug/spike or something broader.
- If it looks like it should be split into multiple stories, ask me: "This could be split into N stories: [list]. Split into separate specs, or keep as one?"
- If I choose split: create each story as a separate file (`<spec_id>-001.md`, `<spec_id>-002.md`, etc.), one at a time, each with its own approval.
- If I choose keep as one: write a single file.

**Common rules:**
- Write each spec to `.copilot/spec/<spec_id>.md` (one file per story/bug/spike, never multiple items in one file).
- Include a `## Changelog` section at the end.
- This spec_id will be used by all downstream tasks (research, design, plan, code, test, review, log).
- If details are missing, ask clarifying questions before writing.
- Present the spec as a draft — iterate until I approve.
- On approval, update frontmatter to `status: approved` with today's date.
