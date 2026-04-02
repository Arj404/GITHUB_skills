---
description: Cross-model review of code, tests, and documentation
agent: Reviewer
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

**Review** all work produced for this spec — code, tests, DevOps configs, and documentation.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Read the design from `.copilot/artifact/${input:spec_id}/design/` if it exists.
- Read the plan from `.copilot/artifact/${input:spec_id}/plan/`.
- Review against the full checklist: correctness, code quality, security, testing, DevOps, docs.
- Verdict: Approved or Changes Requested — with specific, actionable findings.
- Write the review report to `.copilot/artifact/${input:spec_id}/review/`.
