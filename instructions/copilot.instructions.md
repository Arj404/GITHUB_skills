---
applyTo: "**"
---

# Copilot Behavior

## Interaction Rules

- Focus on user intent; do not hallucinate requirements or ask unnecessary questions unless essential for a decision.
- Be concise and efficient with token usage; avoid verbose or redundant responses.
- When instructed "DO NOT", strictly avoid modifying existing code in that scope.
- Use absolute paths in all commands and file references.
- Use PowerShell-compatible syntax (`;` for chaining instead of `&&`) on Windows environments.

## Working Standards

- Before generating code, verify which instruction files apply to the target file type.
- Reference shared instructions and prompts for standards and best practices.
- Cross-reference instruction files using relative paths for maintainability.
- Produce output that conforms to the project's established patterns and conventions.
- When multiple approaches exist, prefer the one aligned with existing codebase patterns.
- If `.copilot/context/paths.md` does not exist when you need to read it, use #tool:execute to run `bash scripts/setup.sh` or create it with default paths (`src/`, `tests/`, etc.) before proceeding.

## Context Budget

- If the full context (spec + design + plan + contracts + code) exceeds your token window, prioritize information in this order:
  1. `graphify` knowledge graph
  2. Spec summary / Plan
  3. Full Design
  4. Full Spec
- Avoid reading entire large files; use graphify and search to extract only necessary information.
- Use progressive detail loading: start with summaries, drill into files only when needed.

## Response Format

- Structure responses with clear headings and sections for complex answers.
- Provide code with inline comments only for non-obvious logic.
- Include file paths when referencing or modifying files.
- When suggesting changes, show before/after context for clarity.

## graphify

Before answering architecture or codebase questions, read `graphify-out/GRAPH_REPORT.md` if it exists.
If `graphify-out/wiki/index.md` exists, navigate it for deep questions.
Type `/graphify` in Copilot Chat to build or update the knowledge graph.