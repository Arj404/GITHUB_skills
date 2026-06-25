# Model Strategy

This document defines which AI models are used for each agent and prompt in the framework, and the rationale behind each choice. Model names are maintained here — not in the README — so that model updates require only a single file change.

---

## Model Assignments

| Category | Model | Prompts / Agents | Rationale |
|----------|-------|-----------------|-----------|
| Requirements & research | **Claude Opus 4.6** | `/spec`, `/research`, `@Product`, `@Researcher` | Deep reasoning for elicitation, technology evaluation, and tradeoff analysis |
| Implementation | **Claude Sonnet 4.6** | `/plan`, `/code`, `/quickfix`, `@Planner`, `@Developer` | Fast, high-quality code generation and planning |
| Utility | **GPT-4.1** | `/registry`, `/status`, `/resume` | Cost-efficient for structured but simple tasks |

---

## Selection Principles

1. **Complexity matches cost** — complex reasoning tasks (spec, research) use the highest-capability model available. Routine generation tasks (plan, code) use a fast, cost-effective model.

2. **Model names are opaque strings** — agents and prompts reference model names from this document. When a model is deprecated or superseded, update the table here and propagate to agent frontmatter.

---

## Updating Models

When a model is deprecated, released, or benchmarked against another:

1. Update the table in this file.
2. Update the relevant `.agent.md` frontmatter fields.
3. Add a `CHANGELOG.md` entry under `## [Unreleased]`.
4. Do **not** update `README.md` — it references this document, not specific model names.

---

## Model Availability Notes

Model availability depends on your GitHub Copilot plan and organization configuration. If a listed model is unavailable in your environment, substitute the nearest equivalent in the same model family and document the substitution here.
