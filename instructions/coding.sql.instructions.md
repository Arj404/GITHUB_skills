---
applyTo: "**/*.{sql}"
---

# SQL Standards

## Naming

- Use `snake_case` for table, column, index, and constraint names.
- Use singular nouns for table names (e.g., `user_account`, not `user_accounts`).
- Prefix indexes with `idx_`, unique constraints with `uq_`, foreign keys with `fk_`.

## Formatting

- Write SQL keywords in UPPERCASE (`SELECT`, `FROM`, `WHERE`, `JOIN`).
- Write identifiers in lowercase.
- Use proper indentation and line breaks for readability in complex queries.
- Never use `SELECT *`; always specify columns explicitly.

## Safety

- Use parameterized queries or prepared statements for all dynamic input — never concatenate user input into SQL.
- Add `WHERE` clauses to all `UPDATE` and `DELETE` statements; never run unqualified mutations.
- Wrap multi-step data changes in explicit transactions with proper rollback handling.

## Performance

- Add indexes for columns used in `WHERE`, `JOIN`, `ORDER BY`, and `GROUP BY` clauses.
- Use `EXPLAIN` / `EXPLAIN ANALYZE` to validate query plans before deploying complex queries.
- Avoid N+1 query patterns; use JOINs or batch fetches instead.

## Migrations

- Use versioned, incremental migration scripts (e.g., `V001__create_user_table.sql`).
- Every migration MUST be reversible or have a documented rollback strategy.
- Never modify or delete an already-applied migration; create a new migration instead.

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [security](security.instructions.md) for data protection rules.
