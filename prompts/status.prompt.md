---
description: Show the current status of a spec and its artifacts
agent: Product
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Show the current status of the specification and its artifacts.

1. **Read the Spec**: Check if `.copilot/spec/${input:spec_id}.md` exists. Extract the `status` from its YAML frontmatter.
2. **Check Artifacts**: Check if the following directories/files exist in `.copilot/artifact/${input:spec_id}/`:
   - `research/recommendation.md`
   - `plan/` (look for any `.md` file — name varies by feature)

3. **Determine Code/Tests Status**: Look at the plan and check if the code and tests mentioned there have been created in the repository.

4. **Output Dashboard**: Display a dashboard-style summary exactly like this:

```markdown
# Status: ${input:spec_id}

## Progress
- [ ] **Spec**: {status} (e.g., draft, approved, in-progress, done)
- [ ] **Research**: {status} (e.g., approved, not started)
- [ ] **Plan**: {status}
- [ ] **Code**: {status} (e.g., in-progress, not started)
- [ ] **Tests**: {status}

## Next Steps
{Recommend the next agent to run based on what is missing or in-progress. E.g., "@Developer to implement the plan."}
```

Use ✅ for completed/approved, 🔄 for in-progress/draft, and ❌ for not started.
