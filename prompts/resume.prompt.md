---
description: Resume an interrupted session by finding the next logical step
agent: Product
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Resume the workflow for the given specification by determining where the process left off.

1. **Scan Artifacts**: Check the existence and status of the following for `${input:spec_id}`:
   - Spec (`.copilot/spec/`)
   - Research (`.copilot/artifact/<spec_id>/research/`)
   - Plan (`.copilot/artifact/<spec_id>/plan/`)
   - Code (check repository for files mentioned in the plan)
   - Tests (check repository)

2. **Determine the Next Logical Step**:
   - If Spec is `draft` -> Continue with `@Product`
   - If Spec is `approved` but no Research -> Route to `@Researcher`
   - If Research exists but no Plan -> Route to `@Planner`
   - If Plan exists but Code is incomplete -> Route to `@Developer`
   - If Code and tests are complete -> Workflow complete

3. **Report to User**:
   - Briefly summarize what has been completed.
   - State exactly which agent to invoke next.
   - Provide a copy-pasteable command to invoke the next agent (e.g., `@Developer Please continue implementation for user-auth`).
