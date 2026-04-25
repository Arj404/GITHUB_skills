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
   - Design (`.copilot/artifact/<spec_id>/design/`)
   - Plan (`.copilot/artifact/<spec_id>/plan/`)
   - Code (check repository for files mentioned in the plan)
   - Tests (check repository)
   - Security Audit (`.copilot/artifact/<spec_id>/security/`)
   - Review (`.copilot/artifact/<spec_id>/review/`)
   - Worklog (`.copilot/artifact/<spec_id>/worklog/`)

2. **Determine the Next Logical Step**:
   - If Spec is `draft` -> Continue with `@Product`
   - If Spec is `approved` but no Research -> Route to `@Researcher`
   - If Research exists but no Design -> Route to `@Architect`
   - If Design exists but no Plan -> Route to `@Planner`
   - If Plan exists but Code is incomplete -> Route to `@Developer`
   - If Code exists but Tests are missing/failing -> Route to `@Tester`
   - If Tests pass but no Security Audit -> Route to `@SecurityAuditor`
   - If Security Audit passed but no DevOps configs -> Route to `@DevOps`
   - If implementation is complete but no Review -> Route to `@Reviewer`
   - If Review is complete but no Worklog -> Route to `@CopilotLogger`

3. **Report to User**:
   - Briefly summarize what has been completed.
   - State exactly which agent to invoke next.
   - Provide a copy-pasteable command to invoke the next agent (e.g., `@Developer Please continue implementation for user-auth`).
