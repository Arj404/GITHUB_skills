# GITHUB_skills — Spec-Driven Development Framework

This project is an AI-powered spec-driven development framework. It provides a structured workflow for turning ideas into specifications, plans, and implementations using AI agents.

## Workflow

The framework uses 4 agents in a handoff chain:

```
Product → Researcher → Planner → Developer
  (spec)    (research)   (plan)    (code)
```

### Agents

| Agent | Role | Command |
|-------|------|---------|
| `@product` | Writes specs, manages the spec backlog | `/spec` |
| `@researcher` | Evaluates tech options (ToT), builds preferences | `/research` |
| `@planner` | Creates detailed implementation plans | `/plan` |
| `@developer` | Implements features with unit tests | `/code` |

### Commands

| Command | What it does |
|---------|-------------|
| `/spec <id>` | Write a feature or bug specification |
| `/research <id>` | Evaluate tech options (ToT), build preferences |
| `/plan <id>` | Create an implementation plan |
| `/code <id>` | Implement with unit tests |
| `/quickfix <id>` | Trivial plan+code+test in one step (<50 LOC) |
| `/registry` | Generate/update spec index |
| `/status <id>` | Dashboard view of a spec's progress |
| `/resume <id>` | Recover an interrupted session |

## Artifact Structure

All AI-generated documents are stored in `.copilot/`:

```
.copilot/
├── context/                    # Project context (human-maintained)
│   ├── overview.md             # Project name, overview, users
│   ├── constraints.md          # Team tech preferences (built by Researcher)
│   └── paths.md                # Repository path configuration
├── spec/                       # Flat catalogue of all specs
│   └── <spec_id>.md
└── artifact/
    └── <spec_id>/
        ├── research/           # Tech evaluation (Researcher)
        └── plan/               # Implementation plan (Planner)
```

## Spec Status Lifecycle

```
draft → approved → in-progress → done
```

Agents gate their execution on status. The Developer won't start unless the spec is `approved` and a plan exists.

## Getting Started

1. Run `/spec <feature-name>` to create a specification.
2. Approve the spec when satisfied.
3. Run `/research <feature-name>` (optional) to evaluate technology choices.
4. Run `/plan <feature-name>` to create an implementation plan.
5. Run `/code <feature-name>` to implement with unit tests.

## Context Files

Before starting, ensure `.copilot/context/` exists with:
- `overview.md` — project name, purpose, tech stack
- `constraints.md` — team tech preferences (starts empty, built by Researcher)
- `paths.md` — repository path configuration

If these don't exist, create them or run `bash scripts/setup.sh`.
