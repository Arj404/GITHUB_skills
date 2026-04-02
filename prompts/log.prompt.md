---
description: Log all changes made during this development session
agent: CopilotLogger
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

**Log** everything done by Copilot agents for this spec into a structured worklog.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Scan `.copilot/artifact/${input:spec_id}/` for all produced artifacts (design, plan, review).
- Search the workspace for all files created or modified during the session.
- Write the worklog to `.copilot/artifact/${input:spec_id}/worklog/${input:spec_id}-worklog.md`.
- Verify all listed artifacts actually exist. Note any skipped agents.
- Include: agent activity, files changed, artifacts produced, metrics, and follow-up items.
