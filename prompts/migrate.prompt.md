---
description: Generate database migrations based on schema designs
agent: Migrator
argument-hint: 'Enter spec_id or describe schema changes needed'
---

The **scope** is: `${input:scope:Scope of migrations (spec_id or description)}`

Please generate database migration scripts for the specified scope.

1. **Analyze Design**: Read the database design for `${input:scope}` (e.g., in `.copilot/artifact/${input:scope}/design/`) or infer the schema changes from the provided description.
2. **Understand Environment**: Scan the source root defined in `.copilot/context/paths.md` to identify the database tooling in use (Alembic, Prisma, raw SQL, etc.).
3. **Generate Scripts**: Write the appropriate up/down migration scripts.
4. **Handoff**: Provide the user with the generated files and instructions on how to apply them, or hand off to the Developer if this is part of a larger workflow.
