# Changelog

All notable changes to this framework are documented here.  
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> **MAJOR** — breaking changes to agent workflows, instruction globs, or prompt contracts  
> **MINOR** — new agents, instructions, prompts, or skills  
> **PATCH** — fixes, clarifications, model swaps, documentation updates

---

## [Unreleased]

### Changed

- **Simplified agentic workflow** — removed 8 agents that were not useful: `Architect`, `Tester`, `Reviewer`, `SecurityAuditor`, `DevOps`, `Migrator`, `CopilotLogger`, `Discovery`. The framework now ships 4 agents: `Product`, `Researcher`, `Planner`, `Developer`.
- Removed 9 prompts tied to the deleted agents: `/design`, `/test`, `/review`, `/audit`, `/cicd`, `/migrate`, `/log`, `/diff`, `/discover`.
- Removed graphify knowledge-graph integration (skill file, output dir, git hooks, all references across agents, prompts, instructions, scripts, CLI, and docs).
- Updated handoffs in the 4 remaining agents: `Product` → `Researcher`/`Planner`; `Researcher` → `Planner`; `Planner` → `Developer`; `Developer` writes unit tests itself (no Tester handoff).
- Updated `MODEL_STRATEGY.md`, `README.md`, `CHEATSHEET.md`, `CONTRIBUTING.md`, `scripts/setup.sh`, `copilot_skills_kit/cli.py`, `bin/cli.js`, `pyproject.toml`, `vscode/tasks.json`, `vscode/settings.json` to reflect the simplified workflow.

### Fixed

- **`CopilotLogger.agent.md`** — model corrected from `GPT-5 mini` to `GPT-4.1` to match `MODEL_STRATEGY.md`; tools YAML line-break removed.
- **`Discovery.agent.md`** — model normalised from `Claude Opus 4.6 (copilot)` to `Claude Opus 4.6` for consistency with all other agents.
- **`DevOps.agent.md`** — model updated from `Claude Sonnet 4.6` to `Gemini 3.1 Pro (Preview)` to match `cicd.prompt.md` and `MODEL_STRATEGY.md`.
- **`MODEL_STRATEGY.md`** — infrastructure model updated from `Gemini 2.5 Pro` to `Gemini 3.1 Pro (Preview)`; `@DevOps` added to its row; `@CopilotLogger` added to the Utility row; Discovery agent row added.
- **`vscode/snippets.json`** — all three spec templates (`spec-feature`, `spec-bug`, `spec-spike`) now use `spec_id:` instead of `id:` to match the framework's spec frontmatter schema; `approved_date: ""` added to all templates.
- **`prompts/status.prompt.md`** — replaced hardcoded `design/design.md` and `plan/plan.md` paths with directory-level checks (`design/`, `plan/`) since agents write to variable filenames.
- **`CONTRIBUTING.md`** — agent frontmatter example updated: stale tool names (`editFiles`, `runCommands`, `ask`) replaced with current names (`edit`, `execute`, `vscode/askQuestions`); added `argument-hint`, `agents`, `handoffs` fields; prompt frontmatter example updated from stale `name`/`mode` fields to actual `description`/`agent`/`argument-hint` fields.

---

## [2.0.0] — 2026-04-26

### Added

- **`MODEL_STRATEGY.md`** — dedicated model reference document; model names removed from README to prevent stale references.
- **`CONTRIBUTING.md`** — contribution guide covering how to add agents, instructions, prompts, and skills.
- **`CHANGELOG.md`** — this file.
- **Architecture diagram** in `README.md` — Mermaid graph showing how agents, prompts, instructions, skills, and artifacts relate.

### Added — Instructions

- `coding.rust.instructions.md` — Rust: ownership, `?` operator, Tokio concurrency.
- `coding.java.instructions.md` — Java: immutability, `Optional`, records, `var`.
- `coding.typescript.instructions.md` — TypeScript: strict mode, branded types, union types, generics.
- `api-versioning.instructions.md` — URI versioning, `Sunset` header policy, deprecation workflow.
- `observability.instructions.md` — Structured JSON logging, RED/USE metrics, distributed tracing.

### Added — Agents

- `Discovery.agent.md` — Discovery agent for initial codebase exploration.
- `Migrator.agent.md` — Database Migrator for up/down migration scripts.
- `SecurityAuditor.agent.md` — OWASP, secrets scanning, dependency audit.

### Added — Prompts

- `/migrate` — generate database migrations from architecture design.
- `/audit` — security audit (OWASP, secrets, dependencies).
- `/status` — dashboard view of a spec's progress and artifacts.
- `/resume` — recover interrupted sessions and find the next logical step.
- `/registry` — generate/update the spec index at `.copilot/spec/REGISTRY.md`.
- `/diff` — generate a structured diff between two spec versions.
- `/discover` — initial codebase discovery and summary.

### Changed

- Researcher `recommendation.md` is now treated as **binding constraints** by the Architect (not re-evaluated).
- Developer ↔ Tester loop is now explicit: Tester hands back to Developer on failures; cycle repeats until all tests pass.
- Pre-condition gates are enforced by each agent before starting work (spec status, upstream artifact status).
- `@Reviewer` agent now uses a priority list of fallback models to ensure cross-model review.

---

## [1.0.0] — 2025-12-01

### Added

- Initial framework release.
- Core agents: `Product`, `Architect`, `Planner`, `Developer`, `Tester`, `Reviewer`, `CopilotLogger`, `DevOps`.
- Core instructions: `copilot`, `architecture`, `coding.standard`, `coding.python`, `coding.javascript`, `coding.go`, `coding.sql`, `coding.terraform`, `testing`, `security`, `quality`, `devops`, `docker`, `ui`, `documentation`, `review`.
- Core prompts: `/spec`, `/research`, `/design`, `/plan`, `/code`, `/test`, `/cicd`, `/review`, `/log`, `/quickfix`.
- `.copilot/` artifact structure: `spec/`, `artifact/<spec_id>/`, `context/`.
- Spec frontmatter schema: `spec_id`, `type`, `status`, `approved_by`, `approved_date`.
- Handoff-driven workflow with approval gates.
- `vscode/settings.json`, `vscode/tasks.json`, `vscode/snippets.json` for VS Code integration.
- Git hooks: `post-commit`, `post-merge`.
