---
description: Write integration and contract tests, then run the full suite
agent: Tester
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Write **integration and contract tests** for this implementation, then run the full test suite.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Read the plan from `.copilot/artifact/${input:spec_id}/plan/`.
- Integration tests → `test/integration/`. Contract tests → `test/contract/`.
- Include security edge cases (injection, auth bypass) and boundary values.
- Run ALL tests (unit + integration + contract). Report results with coverage.
- If implementation bugs are found, report them — never modify source code yourself.
