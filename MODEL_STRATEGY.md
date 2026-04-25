# Model Strategy

This document defines which AI models are used for each agent and prompt in the framework, and the rationale behind each choice. Model names are maintained here — not in the README — so that model updates require only a single file change.

---

## Model Assignments

| Category | Model | Prompts / Agents | Rationale |
|----------|-------|-----------------|-----------|
| Requirements & design | **Claude Opus 4.6** | `/spec`, `/research`, `/design` | Deep reasoning for elicitation, technology evaluation, and system architecture |
| Implementation | **Claude Sonnet 4.6** | `/plan`, `/code`, `/test`, `/quickfix`, `/audit` | Fast, high-quality code generation and planning |
| Database migrations | **Claude Sonnet 4.6** | `/migrate` | Generates robust up/down SQL/ORM migrations |
| Infrastructure | **Gemini 3.1 Pro (Preview)** | `/cicd`, `@DevOps` | Strong at IaC, Dockerfile, and pipeline generation |
| Cross-model review | **GPT-5.2-Codex** | `/review` | Different model family used deliberately to surface blind spots missed by the implementing model |
| Utility | **GPT-4.1** | `/log`, `/registry`, `@CopilotLogger` | Cost-efficient for structured but simple tasks |
| Documentation discovery | **Claude Opus 4.6** | `/discover`, `@Discovery` | Deep reasoning for multi-layer codebase analysis |
| `@Reviewer` agent fallback list | **Claude Sonnet 4 → GPT-4.1 → Gemini 3 Pro** | `@Reviewer` | Priority list ensures a different model than whichever model wrote the code |

---

## Selection Principles

1. **Cross-model review** — the Reviewer agent must always use a different model family than the one that generated the code. The fallback priority list above implements this.

2. **Complexity matches cost** — complex reasoning tasks (spec, design, research) use the highest-capability model available. Routine generation tasks (plan, code, test) use a fast, cost-effective model.

3. **Specialization where it matters** — Gemini is used for `/cicd` because of its strong performance on YAML, Dockerfile, and Terraform generation. This is an empirical observation and should be re-evaluated periodically.

4. **Model names are opaque strings** — agents and prompts reference model names from this document. When a model is deprecated or superseded, update the table here and propagate to agent frontmatter.

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
