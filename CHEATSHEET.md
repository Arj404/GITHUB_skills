# GITHUB_skills Cheat Sheet

> Quick reference for the AI-powered spec-driven development framework.

---

## Prompts (type `/` in Copilot Chat)

| Command | Agent | What it does |
|---------|-------|-------------|
| `/spec` | Product | Write a feature or bug specification |
| `/research` | Researcher | Evaluate tech options (ToT), build preferences |
| `/plan` | Planner | Create a step-by-step implementation plan |
| `/code` | Developer | Implement the feature with unit tests |
| `/quickfix` | Developer | Trivial plan + code + test in one step (<50 LOC) |
| `/registry` | Product | Generate/update spec index at `.copilot/spec/REGISTRY.md` |
| `/status` | Product | Dashboard view of a spec's progress and artifacts |
| `/resume` | Product | Recover an interrupted session, find the next step |

---

## Agents (type `@` in Copilot Chat)

| Agent | Role |
|-------|------|
| `@Product` | Writes specs, manages the product backlog |
| `@Researcher` | Evaluates tech options using Tree-of-Thought |
| `@Planner` | Turns specs into detailed implementation plans |
| `@Developer` | Implements the plan with unit tests |

---

## Common Workflows

### Start a new feature from scratch
```
/spec → /research → /plan → /code
```

### Quick bug fix (<50 LOC)
```
/spec (bug) → /quickfix
```

### Recover an interrupted session
```
/resume <spec_id>
```

### Check the status of any feature
```
/status <spec_id>
```

### Onboard this framework to a new repo
```bash
bash scripts/setup.sh /path/to/your-repo
```

---

## Model Strategy

| Category | Model | Used For |
|----------|-------|---------|
| Requirements & Research | Claude Opus 4.6 | `/spec`, `/research` |
| Implementation | Claude Sonnet 4.6 | `/plan`, `/code`, `/quickfix` |
| Utility | GPT-4.1 | `/registry`, `/status`, `/resume` |

---

## Key Artifacts

| Path | Purpose |
|------|---------|
| `.copilot/spec/<spec_id>.md` | Feature/bug specification |
| `.copilot/artifact/<spec_id>/research/` | Tech evaluation + database model |
| `.copilot/artifact/<spec_id>/plan/` | Implementation plan |
| `.copilot/context/paths.md` | Repository path configuration |
| `.copilot/context/overview.md` | Project summary for agents |
| `.copilot/context/constraints.md` | Team tech preferences |

---

## Spec Status Lifecycle

```
draft → approved → in-progress → done
```

Agents gate their execution on status. `@Developer` won't start unless the spec is `approved` and a plan exists.
