---
description: Show what changed between the implementation and the spec/design — for review prep and completeness verification
agent: Reviewer
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Produce a **diff summary** between what was specified/designed and what was actually implemented for `${input:spec_id}`.

### Steps

1. **Read the Spec**: Load `.copilot/spec/${input:spec_id}.md` — note the acceptance criteria and scope.
2. **Read the Design & Plan**: Load `.copilot/artifact/${input:spec_id}/design/` and `.copilot/artifact/${input:spec_id}/plan/`. Extract:
   - All planned files to create or modify.
   - All planned API endpoints or DB schema changes.
   - All planned test scenarios.
3. **Inspect the Implementation**: Use the knowledge graph (`graphify-out/GRAPH_REPORT.md`) and #tool:search to find the files actually created or modified as part of this spec. Compare against the plan.
4. **Inspect the Tests**: Check for the test files planned vs. actually written.
5. **Generate the Diff Summary** in this format:

```markdown
# Diff Summary: ${input:spec_id}

## Spec vs. Implementation

### ✅ Completed
- {File or feature that was planned and is implemented}

### ⚠️ Partial
- {File or feature that exists but is incomplete — describe what is missing}

### ❌ Missing
- {File or feature that was planned but not found in the codebase}

### ➕ Extra (not in spec)
- {File or feature found in the implementation but not mentioned in the spec/plan — may be tech debt or an undocumented decision}

## Acceptance Criteria Verification

| Criterion | Status | Notes |
|-----------|--------|-------|
| {criterion from spec} | ✅ / ⚠️ / ❌ | {evidence or gap} |

## Recommendation
{1-2 sentences: is this ready for review, or should the developer complete the gaps first?}
```

6. Present the summary to the user.
