---
description: Perform a standalone security audit on a codebase or specific spec
agent: SecurityAuditor
argument-hint: 'Enter spec_id or describe scope (e.g., user-auth or all frontend)'
---

The **scope** is: `${input:scope:Scope of audit (spec_id or description)}`

Perform a full security audit on the specified scope.

1. **Analyze Code**: Review the code relevant to the scope using the knowledge graph and search tools.
2. **Scan for Vulnerabilities**: Check for OWASP Top 10 issues, hardcoded secrets, input validation failures, and authorization flaws based on `security.instructions.md`.
3. **Dependency Audit**: Review package/module files for outdated or vulnerable dependencies.
4. **Report Findings**: Generate a structured security report. If a `spec_id` was provided, write it to `.copilot/artifact/${input:scope}/security/report.md`. If this is a general audit, write it to `docs/security/audit-report.md`.
