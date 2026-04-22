---
description: Scan a codebase and generate three-layer product documentation (overview → areas → deep dives)
agent: Discovery
argument-hint: 'Optional: target directory path (defaults to repo root)'
---

**Scan this codebase** and generate structured, three-layer product documentation.

If a target directory was provided in my message, scope the scan to that directory. Otherwise, scan from the repository root.

Before scanning:
- Check if `docs/` (or the target output directory) already contains Markdown files.
- If existing content is found, ask me how to handle it before proceeding.

## Product-Level Information

During the **Layer 1 scan**, you MUST also capture the following product-level context — not just technical details. Read these additional sources if present:

- `README.md` — primary source for purpose, audience, and feature summary
- `CHANGELOG.md` — version history and key milestones
- `CONTRIBUTING.md` — team/ownership and contribution model
- `LICENSE` — licensing details
- `.github/ISSUE_TEMPLATE/` — understand problem categories and user-reported concerns
- `docs/adr/` or `impl/doc/adr/` — architecture decisions and accepted trade-offs
- Any existing `docs/` Markdown files — prior product-level documentation

The `docs/overview/overview.md` MUST include these additional sections beyond the technical baseline:

| Section | What to capture |
|---------|----------------|
| **Product Goals** | The business problem this solves; success criteria or KPIs if stated |
| **Target Audience** | Who uses this — end-users, developers, internal teams, personas |
| **Key Features & Capabilities** | Bulleted list of the primary user-facing features or capabilities |
| **Non-Functional Requirements** | Performance targets, SLAs, scalability, availability, security posture if inferable |
| **Ownership & Contacts** | Team name, maintainers, or on-call contacts if present in README/CODEOWNERS |
| **Versioning & Changelog** | Current version and a 3–5 item summary of recent releases (from CHANGELOG if present) |
| **Domain Glossary** | 5–10 key domain terms and their definitions as used in this codebase |

If a section has no available information, write a placeholder: `> Not documented — consider adding this to the README.`

## Workflow

Execute the following phases in order. The workflow runs forward (Layers 1 → 2 → 3) and then backward (3 → 2 → 1) to enrich each layer with insights discovered in deeper layers.

### Forward Pass

1. **Layer 1 — Overview**: Scan the codebase (including product sources above) and generate `docs/overview/overview.md` with all sections. Present the draft and ask for my approval before continuing.
2. **Layer 2 — Area Detail**: Identify areas/modules, confirm the list with me, then generate one doc per area in `docs/areas/`. Present drafts and ask for approval.
3. **Layer 3 — Deep Dives**: Generate detailed deep-dive docs per area in `docs/deep-dives/`. Present drafts and ask for final approval.

### Backward Enrichment Pass

After all three layers are approved, execute the enrichment pass in reverse order before generating the index.

#### Step A — Enrich Layer 2 from Layer 3

For each `docs/areas/<area>.md`, re-read the corresponding `docs/deep-dives/<area>.md` and enrich the area document with:

- **Key implementation insights** surfaced in the deep dive (non-obvious algorithms, notable patterns)
- **Tech debt summary** — a brief callout of significant TODOs/FIXMEs found in the deep dive
- **Testing coverage note** — whether the area has strong, partial, or missing test coverage
- **Data flow diagram** — add or update a Mermaid `flowchart` or `sequenceDiagram` showing how data moves through the area (derive from the deep dive's data flow and error handling sections)

Present the enriched Layer 2 drafts and ask for approval before proceeding to Layer 1 enrichment.

#### Step B — Enrich Layer 1 from enriched Layer 2

Re-read all enriched `docs/areas/*.md` files and update `docs/overview/overview.md` with:

- **Architecture Diagram** — a Mermaid `C4Context` or `graph TD` diagram showing all areas as nodes, with edges representing data flows and dependencies between them (derived from each area's Internal/External dependencies and data flow)
- **System Flow Diagram** — a Mermaid `sequenceDiagram` or `flowchart LR` showing the primary end-to-end user journey or request lifecycle across areas
- **Cross-cutting concerns** — security patterns, shared utilities, or common error handling identified across multiple areas
- **Tech debt hotspots** — a rollup of the most significant debt items across all areas, ranked by severity or frequency
- **Feature-to-area mapping** — a table mapping each Key Feature (from the Product Goals section) to the area(s) that implement it

Present the enriched Layer 1 draft and ask for final approval.

### Index Generation

After all enrichment approvals, generate `docs/index.md` linking all completed layers.

Generate `docs/index.md` linking all completed layers when done (or when I choose to stop early at any gate).