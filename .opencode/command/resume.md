---
description: Resume an interrupted session by finding the next logical step
agent: product
---

The **spec_id** is: `$ARGUMENTS`

Resume the workflow for the given specification by determining where the process left off.

1. **Scan Artifacts**: Check the existence and status of the following for `$ARGUMENTS`:
   - Spec (`.copilot/spec/`)
   - Research (`.copilot/artifact/<spec_id>/research/`)
   - Plan (`.copilot/artifact/<spec_id>/plan/`)
   - Code (check repository for files mentioned in the plan)
   - Tests (check repository)

2. **Determine the Next Logical Step**:
   - If Spec is `draft` → Continue with `@product`
   - If Spec is `approved` but no Research → Run `/research $ARGUMENTS`
   - If Research exists but no Plan → Run `/plan $ARGUMENTS`
   - If Plan exists but Code is incomplete → Run `/code $ARGUMENTS`
   - If Code and tests are complete → Workflow complete

3. **Report to User**:
   - Briefly summarize what has been completed.
   - State exactly which command to run next.
   - Provide a copy-pasteable command (e.g., `/code $ARGUMENTS`).
