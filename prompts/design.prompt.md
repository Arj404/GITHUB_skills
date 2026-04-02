---
description: Design technical architecture for a feature or system
agent: Architect
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Design the **technical architecture** for this spec.

- Read the spec from `.copilot/spec/${input:spec_id}.md`.
- Write the design to `.copilot/artifact/${input:spec_id}/design/`.
- Evaluate 2–3 approaches for each key architecture decision.
- **Decide if this feature requires API contracts.** If yes, produce machine-readable contracts (OpenAPI, AsyncAPI, JSON Schema) in `.copilot/artifact/${input:spec_id}/design/contracts/`. If no API surface is involved, state so explicitly.
- Use Mermaid diagrams for all visual representations.
- Present the design as a draft — iterate until I approve.
