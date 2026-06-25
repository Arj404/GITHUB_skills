---
description: Generate or update the spec registry — an index of all specs with status, type, and links
agent: product
---

Generate or update the **spec registry** at `.copilot/spec/REGISTRY.md`.

- Scan all `.md` files in `.copilot/spec/` (excluding REGISTRY.md itself).
- Read the YAML frontmatter from each spec to extract: `spec_id`, `type`, `status`, `approved_by`, `approved_date`.
- Read the first heading (`# Spec: ...`) for the title.
- Check which artifacts exist for each spec in `.copilot/artifact/<spec_id>/` (research, plan).
- Generate a comprehensive index:

```markdown
# Spec Registry

> Auto-generated index of all specifications. Last updated: {YYYY-MM-DD}

## Summary

| Status | Count |
|--------|-------|
| draft | {n} |
| approved | {n} |
| in-progress | {n} |
| done | {n} |

## All Specs

| ID | Title | Type | Status | Approved | Artifacts |
|----|-------|------|--------|----------|-----------|
| {spec_id} | {title} | {type} | {status} | {date or —} | research ✓ plan ✓ |
| … | … | … | … | … | … |
```

- Sort by status (in-progress first, then approved, then draft, then done).
- Use ✓/✗ to indicate which artifacts exist.
- Link each spec_id to its spec file.
- If REGISTRY.md already exists, overwrite it with the latest data.
