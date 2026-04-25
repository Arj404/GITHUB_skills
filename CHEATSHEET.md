# GITHUB_skills Cheat Sheet

> Quick reference for the AI-powered spec-driven development framework.

---

## 📋 Prompts (type `/` in Copilot Chat)

| Command | Agent | What it does |
|---------|-------|-------------|
| `/spec` | Product | Write a feature or bug specification |
| `/research` | Researcher | Evaluate tech options (ToT), build preferences |
| `/design` | Architect | Design the system + produce API/DB contracts |
| `/plan` | Planner | Create a step-by-step implementation plan |
| `/migrate` | Migrator | Generate database up/down migration scripts |
| `/code` | Developer | Implement the feature with unit tests |
| `/test` | Tester | Write integration + contract tests, run suite |
| `/audit` | SecurityAuditor | OWASP, secrets, and dependency security check |
| `/cicd` | DevOps | Set up CI/CD pipeline, Docker, IaC |
| `/review` | Reviewer | Cross-model code review |
| `/log` | CopilotLogger | Generate the session worklog |
| `/quickfix` | Developer | Trivial plan + code + test in one step (<50 LOC) |
| `/registry` | Product | Generate/update spec index at `.copilot/spec/REGISTRY.md` |
| `/status` | Product | Dashboard view of a spec's progress and artifacts |
| `/resume` | Product | Recover an interrupted session, find the next step |
| `/diff` | Reviewer | Show what changed vs. the spec/design (review prep) |
| `/discover` | Discovery | Scan codebase and generate three-layer product documentation |

---

## 🤖 Agents (type `@` in Copilot Chat)

| Agent | Role |
|-------|------|
| `@Product` | Writes specs, manages the product backlog |
| `@Researcher` | Evaluates tech options using Tree-of-Thought |
| `@Architect` | Designs systems, produces API/DB/message contracts |
| `@Planner` | Turns designs into detailed implementation plans |
| `@Migrator` | Generates versioned database migration scripts |
| `@Developer` | Implements the plan with unit tests |
| `@Tester` | Writes integration/contract tests, runs the full suite |
| `@SecurityAuditor` | Performs OWASP + dependency + secrets audit |
| `@DevOps` | Builds CI/CD pipelines, Dockerfiles, and IaC |
| `@Reviewer` | Cross-model code review (uses a different model than Developer) |
| `@CopilotLogger` | Creates the final session worklog artifact |
| `@Discovery` | Scans and documents an unfamiliar codebase |

---

## 🔄 Common Workflows

### Start a new feature from scratch
```
/spec → /research → /design → /plan → /migrate → /code → /test → /audit → /cicd → /review → /log
```

### Quick bug fix (<50 LOC)
```
/spec (bug) → /quickfix → /audit → /review → /log
```

### Review an existing PR
```
/diff <spec_id> → /review
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

## 🧠 Model Strategy

| Category | Model | Used For |
|----------|-------|---------|
| Requirements & Design | Claude Opus 4.6 | `/spec`, `/research`, `/design` |
| Implementation | Claude Sonnet 4.6 | `/plan`, `/code`, `/test`, `/quickfix` |
| Database | Claude Sonnet 4.6 | `/migrate` |
| Security | Claude Sonnet 4.6 | `/audit` |
| Infrastructure | Gemini 3.1 Pro (Preview) | `/cicd` |
| Review | GPT-5.2-Codex | `/review` (cross-model) |
| Utility | GPT-4.1 | `/log`, `/registry` |
| Documentation | Claude Opus 4.6 | `/discover` |

---

## 📁 Key Artifacts

| Path | Purpose |
|------|---------|
| `.copilot/spec/<spec_id>.md` | Feature/bug specification |
| `.copilot/artifact/<spec_id>/design/` | Architecture & contracts |
| `.copilot/artifact/<spec_id>/plan/` | Implementation plan |
| `.copilot/artifact/<spec_id>/security/` | Security audit report |
| `.copilot/artifact/<spec_id>/review/` | Code review findings |
| `.copilot/artifact/<spec_id>/worklog/` | Session audit trail |
| `.copilot/context/paths.md` | Repository path configuration |
| `.copilot/context/overview.md` | Project summary for agents |
| `.copilot/context/constraints.md` | Team tech preferences |
| `graphify-out/GRAPH_REPORT.md` | Knowledge graph summary |

---

## 🚦 Spec Status Lifecycle

```
draft → approved → in-progress → done
```

Agents gate their execution on status. `@Developer` won't start unless the spec is `approved`. `@Tester` won't start unless the spec is `in-progress`.
