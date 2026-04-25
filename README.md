# GitHub Copilot Custom Setup

This folder contains the complete GitHub Copilot customization for this project — instructions, agents, and prompts — designed to be **reusable across any repository** in the organization.

> **New here?** Read [CONTRIBUTING.md](CONTRIBUTING.md) to add agents, instructions, prompts, or skills.  
> **Model choices?** See [MODEL_STRATEGY.md](MODEL_STRATEGY.md).  
> **What changed?** See [CHANGELOG.md](CHANGELOG.md).

---

## Installation

Install via **npm** (no prior install required — works with `npx`):

```bash
# Run once per machine — installs globally into VS Code and the current repo
npx copilot-skills-kit install

# Install into a specific repository
npx copilot-skills-kit install --target ~/projects/my-app

# Install globally only (skip per-repo .github/ copy)
npx copilot-skills-kit install --global-only
```

Or install via **pip**:

```bash
pip install copilot-skills-kit
copilot-skills-kit install
```

Both commands do the same thing:

1. Copy all agents, prompts, and instructions to VS Code's global user prompts directory.
2. Install the `graphify` skill to `~/.copilot/skills/graphify/`.
3. Copy the full framework into `.github/` of the target repository.
4. Create `.vscode/settings.json` if one does not already exist.

---

## Philosophy

| Concept | What it is | Analogy |
|---------|-----------|---------|
| **Instructions** | Coding standards and rules, auto-applied by file type | The team's style guide |
| **Agents** | Persistent AI personas with specific tools and capabilities | Team members (roles) |
| **Prompts** | Reusable tasks that invoke an agent with a specific brief | Work orders |

> **Agents are personas. Prompts are tasks. One persona can do many tasks.**

---

## Folder Structure

```
.github/
├── instructions/          # Auto-applied rules (by file glob)
│   ├── copilot.instructions.md          # Global Copilot behavior
│   ├── architecture.instructions.md     # System design principles
│   ├── coding.standard.instructions.md  # Universal coding rules
│   ├── coding.python.instructions.md    # Python-specific (PEP 8, type hints, pytest)
│   ├── coding.javascript.instructions.md# JS/TS-specific (ES6+, strict TS, eslint)
│   ├── coding.go.instructions.md        # Go-specific (gofmt, modules, golangci-lint)
│   ├── coding.sql.instructions.md       # SQL conventions
│   ├── coding.terraform.instructions.md # Terraform/IaC patterns
│   ├── testing.instructions.md          # Test organization and coverage
│   ├── security.instructions.md         # Security standards
│   ├── observability.instructions.md    # Logging, tracing, RED/USE metrics
│   ├── quality.instructions.md          # Static analysis thresholds
│   ├── devops.instructions.md           # CI/CD and deployment
│   ├── docker.instructions.md           # Dockerfile best practices
│   ├── ui.instructions.md               # Frontend and accessibility
│   ├── documentation.instructions.md    # Doc structure (README, ADR, API docs)
│   └── review.instructions.md           # Code review process
│
├── agents/                # AI personas (who + how)
│   ├── Product.agent.md        # Product Owner — writes specs
│   ├── Researcher.agent.md     # Technology Researcher — evaluates options (ToT)
│   ├── Architect.agent.md      # Solution Architect — designs systems + DB schemas
│   ├── Planner.agent.md        # Technical Lead — creates plans (tasks)
│   ├── Developer.agent.md      # Senior Developer — implements + unit tests
│   ├── Tester.agent.md         # QA Engineer — integration + contract tests
│   ├── SecurityAuditor.agent.md # Security Auditor — OWASP, secrets, deps
│   ├── Migrator.agent.md       # DB Migrator — up/down migration scripts
│   ├── DevOps.agent.md         # DevOps Engineer — CI/CD, Docker, IaC
│   ├── Reviewer.agent.md       # Code Reviewer — cross-model review
│   └── CopilotLogger.agent.md  # Session Logger — audit trail worklog
│
├── prompts/               # Reusable tasks (what)
│   ├── spec.prompt.md          # /spec — write a feature or bug specification
│   ├── research.prompt.md      # /research — evaluate tech options (ToT)
│   ├── design.prompt.md        # /design — architect a system (+ contracts)
│   ├── plan.prompt.md          # /plan — create an implementation plan
│   ├── code.prompt.md          # /code — implement with unit tests
│   ├── test.prompt.md          # /test — write integration/contract tests
│   ├── cicd.prompt.md          # /cicd — set up CI/CD and Docker
│   ├── review.prompt.md        # /review — cross-model code review
│   ├── log.prompt.md           # /log — session worklog
│   ├── quickfix.prompt.md      # /quickfix — trivial plan+code+test in one step
│   ├── registry.prompt.md      # /registry — generate spec index/catalogue
│   ├── audit.prompt.md         # /audit — security audit (OWASP, secrets, deps)
│   ├── migrate.prompt.md       # /migrate — generate database migrations
│   ├── status.prompt.md        # /status — dashboard view of a spec's progress
│   └── resume.prompt.md        # /resume — recover interrupted sessions
│
└── README.md              # ← You are here
```

---

## Instructions (Auto-Applied Rules)

Instructions are **automatically applied** based on the file you're editing. You never need to invoke them manually.

| Instruction | Applied To | Purpose |
|-------------|-----------|---------|
| `copilot` | `**` (all files) | Copilot behavior: concise, absolute paths, PowerShell conventions |
| `architecture` | `**/*.{py,go,ts,js,jsx,tsx,sql,tf,yaml,yml,json,md}` | Separation of concerns, API design, module structure |
| `coding.standard` | `**` | Naming, functions, error handling, DRY, commits |
| `coding.javascript` | `**/*.{js,jsx,mjs,cjs}` | ES6+, strict mode, eslint/prettier |
| `coding.typescript` | `**/*.{ts,tsx}` | Strict mode, generic constraints, branded types, union types |
| `coding.python` | `**/*.{py,pyi}` | PEP 8, type hints, pytest, ruff/mypy |
| `coding.go` | `**/*.go` | Effective Go, modules, golangci-lint, race detection |
| `coding.rust` | `**/*.rs` | Ownership, error handling (`?`), tokio concurrency |
| `coding.java` | `**/*.java` | Immutability, Optional, modern features (records, var) |
| `coding.sql` | `**/*.{sql}` | SQL conventions, parameterized queries, migrations |
| `coding.terraform` | `**/*.{tf,tfvars,hcl}` | Terraform modules, state management, providers |
| `api-versioning` | `**/*.{ts,js,py,go,java,rs,yaml,yml,json}` | URI versioning, deprecation headers, Sunset policy, breaking changes |
| `testing` | `**` | AAA pattern, test/unit/ + test/integration/ + test/contract/ |
| `security` | `**` | Auth, secrets, input/output, OWASP, dependency scanning |
| `observability` | `**/*.{py,go,ts,js,java,cs}` | Structured JSON logging, RED/USE metrics, tracing |
| `quality` | `**/*.{py,ts,js,jsx,tsx,sql,tf}` | Static analysis, code smells, complexity thresholds |
| `devops` | `**/*.{yaml,yml,tf,sh,cmd,ps1,Dockerfile}` | CI/CD pipeline stages, containerization |
| `docker` | `**/Dockerfile*,**/docker-compose*.{yml,yaml}` | Multi-stage, slim bases, non-root, health checks |
| `ui` | `**/*.{html,css,scss,less,js,ts,jsx,tsx,vue,svelte}` | Accessibility, responsive, Material Design |
| `documentation` | `**/*.{md,mdx,rst,txt,adoc}` | README structure, API docs, ADRs, changelog |
| `review` | `**` | PR guidelines, review checklist, feedback tone |

### How instructions work

Each instruction file has YAML frontmatter with an `applyTo` glob pattern. When you edit a file matching that pattern, the instruction is automatically included in the AI's context. No action needed.

```yaml
---
applyTo: "**/*.{py,pyi}"
---
Follow PEP 8. Use type hints everywhere. Prefer pytest for testing.
```

---

## Agents (AI Personas)

Agents are **persistent AI personas** you switch to with `@AgentName`. Each agent has its own tools, instruction references, handoffs, and output paths.

| Agent | Persona | Model | Key Tools | Writes To |
|-------|---------|-------|-----------|-----------|
| `@Product` | Product Owner | Claude Opus 4.6 | agent, edit, read, web, vscode/askQuestions | `.copilot/spec/` |
| `@Researcher` | Technology Researcher | Claude Opus 4.6 | agent, edit, search, read, web/fetch, vscode/askQuestions | `.copilot/artifact/<spec_id>/research/` |
| `@Architect` | Solution Architect | Claude Opus 4.6 | agent, edit, search, read, web/fetch, vscode/askQuestions | `.copilot/artifact/<spec_id>/design/` |
| `@Planner` | Technical Lead | Claude Sonnet 4.6 | agent, edit, search, read, execute, vscode/askQuestions | `.copilot/artifact/<spec_id>/plan/` |
| `@Developer` | Senior Developer | Claude Sonnet 4.6 | agent, edit, search, read, execute, web, vscode/askQuestions | `impl/src/` + `test/unit/` |
| `@Tester` | QA Engineer | Claude Sonnet 4.6 | agent, edit, search, read, execute, vscode/askQuestions | `test/integration/` + `test/contract/` |
| `@Migrator` | Database Migrator | Claude Sonnet 4.6 | agent, edit, search, read, execute, vscode/askQuestions | Migration scripts |
| `@SecurityAuditor` | Security Auditor | Claude Sonnet 4.6 | agent, edit, search, read, execute, vscode/askQuestions | `.copilot/artifact/<spec_id>/security/` |
| `@DevOps` | DevOps Engineer | Gemini 3.1 Pro (Preview) | agent, edit, search, read, web, execute, vscode/askQuestions | Pipelines, Dockerfiles, IaC |
| `@Reviewer` | Code Reviewer | GPT-5.2-Codex | agent, edit, search, read, web, vscode/askQuestions | `.copilot/artifact/<spec_id>/review/` |
| `@CopilotLogger` | Session Logger | GPT-4.1 | agent, edit, search, read, vscode/askQuestions | `.copilot/artifact/<spec_id>/worklog/` |
| `@Discovery` | Documentation Discovery | Claude Opus 4.6 | agent, edit, search, read, vscode/askQuestions | `docs/` |

### Handoff Flow

```
┌──────────┐     ┌────────────┐     ┌───────────┐     ┌─────────┐     ┌───────────┐     ┌────────┐     ┌─────────────────┐     ┌────────┐     ┌──────────┐     ┌──────────────┐
│ Product  │────▶│ Researcher │────▶│ Architect │────▶│ Planner │────▶│ Developer │◀───▶│ Tester │────▶│ SecurityAuditor  │────▶│ DevOps │────▶│ Reviewer │────▶│ CopilotLogger│
│          │     │ (optional) │     │ (optional)│     │         │     │           │     │        │     │                 │     │        │     │          │     │              │
└────┬─────┘     └─────┬──────┘     └─────┬─────┘     └────┬────┘     └─────┬─────┘     └───┬────┘     └────────┬────────┘     └───┬────┘     └────┬─────┘     └──────────────┘
     │                 │                  │                │                │               │                   │                  │              │
  🔒 Gate:          🔒 Gate:           🔒 Gate:         🔒 Gate:           🔒 Gate:           │              🔒 Gate:               │           🔒 Gate:
  (none)           spec=approved      spec=approved   spec=approved    spec=approved        │           tests=pass                │          Changes ?
                                      +research=       +design=        +plan exists         │                                     │          → loop back
  📝 Output:       📝 Output:           approved         approved                            │           📝 Output:                │
  spec/            research/                                          📝 Output:            │           security/             📝 Output:   📝 Output:
                   +constraints.md      📝 Output:      📝 Output:     src/ +              tests/      report.md            CI/CD +     review/
  🔄 Approval:     🔄 Approval:         design/ +       plan/          test/unit/          (int+con)                        Docker
  Approve /        Approve /           contracts/                                                                                        🔄 Verdict:
  Request Changes  Request Changes                                                                                                       Approved /
                                       🔄 Approval:                                                                                      Changes Req.
                                       Approve /
                                       Request Changes
```

**Key mechanics:**

- **Handoff buttons** appear in chat after each agent completes. Click to proceed to the next agent.
- **Approval gates** (Product, Researcher, Architect) ask explicit Approve/Request Changes via `askQuestions`. Handoff buttons shown only after approval.
- **Pre-condition gates** — each agent verifies upstream artifacts are approved before starting work.
- **Cross-model review** — the Reviewer agent uses a different model than Developer to catch blind spots.
- **Data contracts** — Researcher's `recommendation.md` is treated as **binding constraints** by the Architect (not re-evaluated).
- **Dev ↔ Test loop** — Tester hands back to Developer on failures; cycle repeats until all tests pass.

---

## Prompts (Tasks)

Prompts are **slash commands** you invoke in chat. Each prompt delegates to a custom agent and takes a `spec_id` as input.

### How `spec_id` input works

Every prompt uses the VS Code `${input:spec_id}` variable. When you run a prompt, **VS Code shows an input dialog** asking for the spec_id value. You can also type additional context after the slash command.

**Usage:**

```
/spec                    → VS Code prompts: "Feature name e.g. user-auth"
                           You type: user-auth
                           Additional context in chat: "JWT-based authentication with refresh tokens"

/code                    → VS Code prompts: "Spec ID e.g. user-auth"
                           You type: user-auth
                           Additional context in chat: "Focus on the login endpoint first"
```

The `spec_id` is the **thread** that connects all artifacts. Use the same value across all tasks for one feature/bug.

### Prompt Reference

| Prompt | Agent | Model | What it does |
|--------|-------|-------|-------------|
| `/spec` | Product | Claude Opus 4.6 | Write a feature or bug specification (asks which type) |
| `/research` | Researcher | Claude Opus 4.6 | Evaluate tech options (ToT), build preferences, produce DB model |
| `/design` | Architect | Claude Opus 4.6 | Architect a system + produce contracts (if applicable) |
| `/plan` | Planner | Claude Sonnet 4.6 | Create implementation plan |
| `/migrate` | Migrator | Claude Sonnet 4.6 | Generate database migrations based on architecture design |
| `/code` | Developer | Claude Sonnet 4.6 | Implement with unit tests |
| `/test` | Tester | Claude Sonnet 4.6 | Write integration/contract tests, run suite |
| `/audit` | SecurityAuditor | Claude Sonnet 4.6 | Perform security audit (OWASP, secrets, dependencies) |
| `/cicd` | DevOps | Gemini 3.1 Pro (Preview) | Set up CI/CD, Docker, deployment |
| `/review` | Reviewer | GPT-5.2-Codex | Cross-model code review |
| `/log` | CopilotLogger | GPT-4.1 | Session worklog |
| `/quickfix` | Developer | Claude Sonnet 4.6 | Trivial plan+code+test in one step (<50 LOC) |
| `/registry` | Product | GPT-4.1 | Generate/update spec index at `.copilot/spec/REGISTRY.md` |
| `/status` | Product | Claude Opus 4.6 | Dashboard view of a spec's progress and artifacts |
| `/resume` | Product | Claude Opus 4.6 | Recover interrupted sessions and find the next logical step |
| `/diff` | Reviewer | GPT-5.2-Codex | Show what changed vs. the spec/design (review prep) |
| `/discover` | Discovery | Claude Opus 4.6 | Scan codebase and generate three-layer product documentation |
### Model Strategy

Model assignments are maintained in **[MODEL_STRATEGY.md](MODEL_STRATEGY.md)** to avoid stale references here. That document covers model-to-prompt/agent mapping, selection principles, and how to update models when they change.

---

## Artifacts (`.copilot/` Folder)

All AI-generated documents are stored in `.copilot/`, organized by type and spec_id.

```
.copilot/
├── context/                               # Project context (human-maintained)
│   ├── overview.md                        # Project name, overview, users, capabilities
│   └── constraints.md                     # Team tech preferences (built by Researcher)
├── spec/                                  # Flat catalogue of all specs
│   ├── REGISTRY.md                        # Auto-generated spec index (/registry)
│   ├── user-auth.md                       # Feature spec (Product)
│   ├── BUG-1234.md                        # Bug spec (Product)
│   └── dashboard-redesign.md
│
└── artifact/
    ├── user-auth/                         # Per-spec artifacts
    │   ├── research/                      # Tech evaluation (Researcher)
    │   │   ├── compute-platform.md        # ToT: GKE vs Cloud Run vs ...
    │   │   ├── database-model.md          # Conceptual ERD, entities, indexes
    │   │   └── recommendation.md          # Summary of all decisions
    │   ├── design/                        # Architecture (Architect)
    │   │   ├── user-auth.md               # Design doc (includes refined DB schema)
    │   │   └── contracts/                 # Machine-readable API contracts (if applicable)
    │   │       ├── openapi.yaml           # REST API contract
    │   │       ├── events.asyncapi.yaml   # Event contract (if event-driven)
    │   │       └── schemas/               # Shared JSON schemas
    │   │           └── user.schema.json
    │   ├── plan/                          # Implementation plan (Planner)
    │   │   └── user-auth.md
    │   ├── review/                        # Review report (Reviewer)
    │   │   └── user-auth-review.md
    │   └── worklog/                       # Session log (CopilotLogger)
    │       └── user-auth-worklog.md
    │
    ├── BUG-1234/
    │   ├── plan/
    │   ├── review/
    │   └── worklog/
    │
    └── reviews/                           # Standalone reviews (no spec)
        └── 20260220_1430-security-audit.md
```

### Why this structure?

- **Specs are flat** — they're a shared catalogue across the project, not nested per-feature.
- **Context is human-maintained** — `overview.md` gives agents project context; `constraints.md` is built by the Researcher as tech decisions are made.
- **Artifacts are grouped by spec_id** — everything related to one feature/bug lives together.
- **Contracts are optional** — the Architect decides during `/design` whether API contracts are needed. Downstream agents check if `design/contracts/` exists.
- **Research is optional** — the Researcher evaluates tech options and builds preferences over time. Run `/research` before `/design` when technology decisions are needed.
- **Preferences grow over time** — `.copilot/context/constraints.md` is organized into layers (Infrastructure, Backend, Frontend, Data, Observability, Security, Testing) with a Quick Reference table and Decision Log. Starts empty, populated incrementally by the Researcher as the team makes decisions across features.
- **REGISTRY.md** — auto-generated index of all specs with status, type, and artifact links. Run `/registry` to update.
- **Standalone reviews** — the Reviewer can be used outside the flow for ad-hoc code reviews.

### Spec Metadata (Frontmatter)

Every spec includes YAML frontmatter for workflow control:

```yaml
---
spec_id: user-auth
type: feature              # feature | bugfix | refactor | infra | ui-only
status: draft              # draft → approved → in-progress → done
approved_by:               # Human fills this on approval
approved_date:             # Date of approval
---
```

- **`status`** drives gate checks: Planner won't plan unless spec is `approved`, Developer won't code unless plan exists.
- **`type`** is informational — classifies the work for the registry.
- The **Changelog** section at the bottom of each spec tracks in-document changes alongside Git history.

---

## Framework Architecture

The diagram below shows how the four artifact types relate to each other at runtime.

```mermaid
graph TD
    P["Prompts\n/spec, /code, /review ..."] -->|invoke| A["Agents\n@Product, @Developer, @Tester ..."]
    A -->|follow| I["Instructions\ncoding, security, testing ..."]
    A -->|load| S["Skills\n/graphify"]
    A -->|read & write| AR["Artifacts\n.copilot/spec/\n.copilot/artifact/"]
    A -->|handoff to| A
    P -->|scoped by| I
```

| Layer | Lives in | Applied by |
|-------|----------|------------|
| **Instructions** | `instructions/` | VS Code automatically, based on `applyTo` glob |
| **Agents** | `agents/` | You switch with `@AgentName` or a prompt delegates |
| **Prompts** | `prompts/` | You invoke with `/command` |
| **Skills** | `skills/` | You invoke with `/trigger` or auto-loaded via settings |
| **Artifacts** | `.copilot/` | Agents read and write; humans approve |

---

## Typical Workflow

There are **two ways** to drive the workflow: **handoff-driven** (recommended) and **prompt-driven** (ad-hoc).

### Mode 1: Handoff-Driven (Recommended for Features)

You type **one prompt** to start, then follow handoff buttons through the chain. Each agent asks for explicit **Approve / Request Changes** before proceeding.

**Human inputs: 1 typed prompt + approval decisions + tech preference answers + handoff clicks.**

### Mode 2: Prompt-Driven (Ad-Hoc / Re-Runs)

Use standalone prompts to enter mid-flow, re-run a stage, or work across sessions:

```
/spec user-auth         → Start from scratch
/research user-auth     → Evaluate tech options (builds preferences over time)
/design user-auth       → Resume at design (spec already exists)
/plan user-auth         → Re-run planning
/code user-auth         → Re-run just implementation
/test user-auth         → Re-run just tests
/review user-auth       → Standalone review outside the flow
/quickfix fix-typo      → Trivial combined plan+code+test
/registry               → Update the spec index
```

---

## End-to-End Flow (Detailed)

This section shows **exactly** what happens at each step — what the human does, what the agent does, what artifacts are produced, and what gates are enforced.

### Step 1: Specification — `@Product` via `/spec`

| | Detail |
|---|---|
| **You type** | `/spec user-auth` + optional context: *"JWT-based auth with refresh tokens"* |
| **VS Code shows** | Input dialog: *"Spec ID e.g. user-auth or BUG-1234"* → you enter `user-auth` |
| **Model** | Claude Opus 4.6 |
| **Pre-condition** | None (first step) |

> **Rule: 1 file = 1 story/bug.** A single spec file never contains multiple stories. If the input is too broad, the agent asks whether to split.

**Agent workflow:**

```
1. 🤖 Reads .copilot/context/overview.md for project context
2. 🤖 Asks: "Feature or Bug?" (askQuestions: Feature / Bug)
3. 👤 You answer: "Feature"
4. 🤖 Asks clarifying questions about requirements (one at a time)
5. 👤 You answer each question
6. 🤖 SCOPE CHECK — evaluates whether the input is a single focused story or broader:
   If single story → proceeds to write one spec file.
   If broader (epic-sized scope):
   ┌──────────────────────────────────────────────────────────────────┐
   │ 🤖 Asks: "This could be split into 3 stories:                    │
   │     1. user-auth-001 — JWT token issuance                        │
   │     2. user-auth-002 — Refresh token rotation                    │
   │     3. user-auth-003 — Session management                        │
   │    Split into separate specs, or keep as one?"                   │
   │                                                                  │
   │ 👤 You choose: "Split" or "Keep as one"                          │
   │                                                                  │
   │ If Split:                                                        │
   │   → Creates each story as a separate file, ONE AT A TIME:        │
   │     .copilot/spec/user-auth-001.md → draft → approve             │
   │     .copilot/spec/user-auth-002.md → draft → approve             │
   │     .copilot/spec/user-auth-003.md → draft → approve             │
   │   → Handoff buttons shown after ALL stories are approved.        │
   └──────────────────────────────────────────────────────────────────┘

7. 🤖 Writes spec draft to .copilot/spec/user-auth.md (or user-auth-001.md if split)
      Frontmatter: spec_id: user-auth, type: feature, status: draft
      Content: overview, goals, user stories, functional/non-functional requirements,
               acceptance criteria, out of scope, success metrics, changelog
8. 🤖 Asks: "Approve or Request Changes?" (askQuestions)
9.    ↕ If Request Changes → you explain what to change → agent iterates → asks again
10. 👤 You select: "Approve"
11. 🤖 Updates frontmatter: status: approved, approved_by: human, approved_date: 2026-02-23
12.    If split and more stories remain → proceeds to next story (back to step 7)
       If all done → shows handoff buttons:
       [Research Technical Options] [Design Architecture] [Plan Implementation]
```

**Artifacts produced:**

| Scenario | Files |
|----------|-------|
| Single story | `.copilot/spec/user-auth.md` |
| Split (3 stories) | `.copilot/spec/user-auth-001.md`, `user-auth-002.md`, `user-auth-003.md` |

---

### Step 2: Research — `@Researcher` via `/research` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Research Technical Options]` handoff **or** type `/research user-auth` |
| **Model** | Claude Opus 4.6 |
| **Pre-condition** | Spec `status: approved` ← verified automatically; **stops with warning** if not met |

**Agent workflow:**

```
1. 🤖 Gate check: reads .copilot/spec/user-auth.md → verifies status: approved ✓
2. 🤖 Reads .copilot/context/constraints.md for existing team preferences
3. 🤖 Reads .copilot/context/overview.md for project context
4. 🤖 Identifies technology decisions needed from the spec
   (e.g., database, compute platform, auth provider, message broker)

5. 🤖 PREFERENCE DISCOVERY (one question at a time, per category):
   ──────────────────────────────────────────────────────────
   🤖 "For the Backend layer — what database do you prefer?"
      Options: PostgreSQL / MySQL / MongoDB / Evaluate options for me
   👤 You answer: "PostgreSQL"
   🤖 Records preference → moves to next decision

   🤖 "For the Infrastructure layer — compute platform?"
      Options: GKE / Cloud Run / Cloud Functions / Evaluate options for me
   👤 You answer: "Evaluate options for me"

6. 🤖 TREE-OF-THOUGHT ANALYSIS (when you say "Evaluate"):
   ──────────────────────────────────────────────────────────
   🤖 Evaluates 3–5 options with weighted comparison matrix:
      ┌──────────────┬───────────┬──────────┬──────────┬───────┐
      │ Criterion    │ Weight    │ GKE      │ CloudRun │ CF    │
      ├──────────────┼───────────┼──────────┼──────────┼───────┤
      │ Scalability  │ 30%       │ 9        │ 8        │ 6     │
      │ Cost         │ 25%       │ 5        │ 8        │ 9     │
      │ Complexity   │ 20%       │ 4        │ 8        │ 9     │
      │ ...          │ ...       │ ...      │ ...      │ ...   │
      ├──────────────┼───────────┼──────────┼──────────┼───────┤
      │ TOTAL        │ 100%      │ 6.2      │ 7.8      │ 7.1   │
      └──────────────┴───────────┴──────────┴──────────┴───────┘
   🤖 Presents comparison + recommendation
   👤 You choose: "Cloud Run"

7. 🤖 DATABASE MODELING (if spec involves data persistence):
   ──────────────────────────────────────────────────────────
   🤖 Produces conceptual ERD: entities, relationships, key attributes, indexes

8. 🤖 Writes all research artifacts
9. 🤖 Updates .copilot/context/constraints.md with new decisions
10. 🤖 Asks: "Approve or Request Changes?" (askQuestions)
11.   ↕ If Request Changes → iterate → ask again
12. 👤 You select: "Approve"
13. 🤖 Updates recommendation.md: Status: Approved
14. 🤖 Shows handoff buttons: [Design Architecture] [Plan Implementation]
```

**Artifacts produced:**

| File | Content |
|------|---------|
| `.copilot/artifact/user-auth/research/compute-platform.md` | ToT analysis: options, weighted matrix, recommendation |
| `.copilot/artifact/user-auth/research/database-model.md` | Conceptual ERD, entities, relationships, indexes |
| `.copilot/artifact/user-auth/research/recommendation.md` | **Binding decisions** — Chosen Technology Stack table + Constraints for Architect |
| `.copilot/context/constraints.md` | Updated with new Quick Reference entries + Decision Log |

> **Key:** `recommendation.md` includes a **Chosen Technology Stack** table and **Constraints for Architect** section that downstream agents treat as binding (not re-evaluated).

---

### Step 3: Architecture — `@Architect` via `/design` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Design Architecture]` handoff **or** type `/design user-auth` |
| **Model** | Claude Opus 4.6 |
| **Pre-condition** | Spec `status: approved` **AND** research `recommendation.md` Status: `Approved` (if research exists) |

**Agent workflow:**

```
1. 🤖 Gate check: reads spec → status: approved ✓
   🤖 Gate check: reads recommendation.md → Status: Approved ✓
2. 🤖 Reads ALL inputs:
   ├── .copilot/spec/user-auth.md                    (spec)
   ├── .copilot/context/constraints.md                (team preferences)
   ├── .copilot/artifact/user-auth/research/          (all research files)
   │   ├── recommendation.md                          (BINDING constraints)
   │   ├── compute-platform.md                        (detailed analysis)
   │   └── database-model.md                          (conceptual model)
   └── existing codebase patterns                     (impl/src/)

3. 🤖 DESIGN (treats research choices as binding — does NOT re-evaluate):
   ──────────────────────────────────────────────────────────
   - System context diagram (Mermaid)
   - Container / component diagrams (Mermaid)
   - Technology Decisions table (from research — copied, not re-evaluated)
   - Component design with responsibilities and interfaces
   - Data flow and sequence diagrams
   - Database schema: refines conceptual ERD → physical DDL, indexes, migrations
   - API contracts (if applicable): OpenAPI 3.1, AsyncAPI, JSON Schema
   - Security considerations
   - Risks and mitigations

4. 🤖 Writes design document + contracts
5. 🤖 Asks: "Approve or Request Changes?" (askQuestions)
6.    ↕ If Request Changes → iterate → ask again
7. 👤 You select: "Approve"
8. 🤖 Updates design: Status: Approved
9. 🤖 Shows handoff button: [Plan Implementation]
```

**Artifacts produced:**

| File | Content |
|------|---------|
| `.copilot/artifact/user-auth/design/user-auth.md` | Full design doc with Mermaid diagrams, DB schema (DDL), component design |
| `.copilot/artifact/user-auth/design/contracts/openapi.yaml` | REST API contract (OpenAPI 3.1) — **if API surface exists** |
| `.copilot/artifact/user-auth/design/contracts/events.asyncapi.yaml` | Event contract — **if event-driven** |
| `.copilot/artifact/user-auth/design/contracts/schemas/*.schema.json` | Shared JSON schemas — **if applicable** |

---

### Step 4: Planning — `@Planner` via `/plan` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Plan Implementation]` handoff **or** type `/plan user-auth` |
| **Model** | Claude Sonnet 4.6 |
| **Pre-condition** | Spec `status: approved` **AND** design approved (if design exists) |

**Agent workflow:**

```
1. 🤖 Gate check: reads spec → status: approved ✓
   🤖 Gate check: reads design → Status: Approved ✓ (if exists)
2. 🤖 Reads ALL inputs:
   ├── .copilot/spec/user-auth.md                (spec)
   ├── .copilot/artifact/user-auth/design/        (design + contracts)
   └── existing codebase                          (discovers patterns, structure, deps)

3. 🤖 Uses a sub-agent to deeply research the codebase (no plan yet)
4. 🤖 May ask clarifying questions via askQuestions
5. 👤 You answer if asked

6. 🤖 PLAN DESIGN (NO code blocks — describes changes only):
   ──────────────────────────────────────────────────────────
   - Ordered task breakdown with dependencies
   - File and symbol references (what to create/modify)
   - Unit test expectations per task
   - Estimated complexity per task
   - Cross-references to spec sections + design decisions

7. 🤖 Writes plan
8. 🤖 Presents plan for review
9. 👤 You review, provide feedback or click [Start Implementation]
```

**Artifacts produced:**

| File | Content |
|------|---------|
| `.copilot/artifact/user-auth/plan/user-auth.md` | Ordered task list with file refs, test expectations, no code blocks |

---

### Step 5: Implementation — `@Developer` via `/code` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Start Implementation]` handoff **or** type `/code user-auth` |
| **Model** | Claude Sonnet 4.6 |
| **Pre-condition** | Spec `status: approved` **AND** plan exists in `.copilot/artifact/<spec_id>/plan/` |

**Agent workflow:**

```
1. 🤖 Gate check: reads spec → status: approved ✓
   🤖 Gate check: plan exists ✓

2. 🤖 Reads ALL inputs:
   ├── .copilot/artifact/user-auth/plan/user-auth.md  (plan — followed step by step)
   ├── .copilot/spec/user-auth.md                      (spec — for requirement context)
   ├── .copilot/artifact/user-auth/design/              (design + contracts — if exist)
   └── existing codebase                                (patterns, conventions)

3. 🤖 IMPLEMENT (follows plan tasks in order):
   ──────────────────────────────────────────────────────────
   For each plan task:
   a. Create/modify source files in impl/src/
   b. Write unit tests in test/unit/
   c. Run tests + linters → fix if failing
   d. Move to next task

4. 🤖 SPEC FEEDBACK LOOP:
   If spec is incomplete/contradictory → STOPS and flags to human
   Does NOT silently work around spec gaps

5. 🤖 Self-verify: runs all unit tests + linter checks
6. 🤖 Presents summary: files changed, tests written, pass/fail, deviations from plan
7. 🤖 Shows handoff button: [Write Integration & Contract Tests]
```

**Artifacts produced:**

| Location | Content |
|----------|---------|
| `impl/src/` | Production source code following plan + design |
| `test/unit/` | Unit tests (AAA pattern, ≥80% coverage target) |

---

### Step 6: Testing — `@Tester` via `/test` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Write Integration & Contract Tests]` handoff **or** type `/test user-auth` |
| **Model** | Claude Sonnet 4.6 |
| **Pre-condition** | None enforced (relies on upstream flow) |

**Agent workflow:**

```
1. 🤖 Reads ALL inputs:
   ├── .copilot/spec/user-auth.md                         (spec)
   ├── .copilot/artifact/user-auth/design/                 (design)
   ├── .copilot/artifact/user-auth/design/contracts/       (API contracts — if exist)
   ├── .copilot/artifact/user-auth/plan/user-auth.md       (plan)
   └── impl/src/ + test/unit/                              (code + existing unit tests)

2. 🤖 WRITE TESTS:
   ──────────────────────────────────────────────────────────
   - Integration tests → test/integration/
   - Contract tests → test/contract/ (validates against OpenAPI/AsyncAPI/JSON Schema)
   - Security edge cases (injection, auth bypass, boundary values)

3. 🤖 RUN ALL TESTS (unit + integration + contract)
4. 🤖 Evaluates results:

   If failures:
   ┌─────────────────────────────────────────────────────────┐
   │ 🤖 Reports which tests failed and why                   │
   │ 🤖 Shows handoff: [Fix Failing Tests] → @Developer      │
   │ 👤 You click → Developer fixes → hands back to Tester   │
   │    ↕ Loop continues until ALL tests pass                 │
   └─────────────────────────────────────────────────────────┘

   If all pass:
   🤖 Reports: test counts, coverage %, pass/fail summary
   🤖 Shows handoff: [All Tests Pass → DevOps]
```

**Artifacts produced:**

| Location | Content |
|----------|---------|
| `test/integration/` | Integration tests (module interactions, DB, APIs) |
| `test/contract/` | Contract tests (validates implementation against OpenAPI/AsyncAPI/JSON Schema) |

> **Note:** Tester NEVER modifies source code in `impl/src/`. Only Developer does.

---

### Step 7: DevOps — `@DevOps` via `/cicd` or handoff

| | Detail |
|---|---|
| **You do** | Click `[All Tests Pass → DevOps]` handoff **or** type `/cicd user-auth` |
| **Model** | Gemini 3.1 Pro (Preview) |
| **Pre-condition** | None enforced |

**Agent workflow:**

```
1. 🤖 Reads spec + plan + scans existing infrastructure:
   ├── CI/CD pipelines (.github/workflows/, etc.)
   ├── Dockerfiles, docker-compose
   ├── IaC (*.tf, *.tfvars)
   └── Scripts, configs

2. 🤖 GENERATES / UPDATES:
   ──────────────────────────────────────────────────────────
   - CI/CD pipeline: lint → build → test → security scan → deploy
   - Dockerfile (multi-stage, slim base, non-root, health checks)
   - docker-compose (if applicable)
   - IaC (Terraform modules, if applicable)
   - Deployment configs, rollback procedures

3. 🤖 VALIDATES: terraform validate, docker build, YAML syntax
4. 🤖 DOCUMENTS: setup instructions, deploy steps, rollback guide
5. 🤖 Shows handoff: [Review All Work]
```

**Artifacts produced:**

| Location | Content |
|----------|---------|
| CI/CD pipelines | GitHub Actions / GitLab CI / etc. |
| `Dockerfile`, `docker-compose.yaml` | Container configs |
| `*.tf`, `*.tfvars` | Infrastructure-as-Code (if applicable) |
| `impl/doc/` or README | Setup, deploy, rollback docs |

---

### Step 8: Review — `@Reviewer` via `/review` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Review All Work]` handoff **or** type `/review user-auth` |
| **Model** | GPT-5.2-Codex (prompt) / Claude Sonnet 4 / GPT-4.1 / Gemini 3 Pro (agent) |
| **Pre-condition** | None enforced |

> **Cross-model review:** The Reviewer intentionally uses a **different model family** than the Developer (Claude Sonnet 4.6) to catch blind spots.

**Agent workflow:**

```
1. 🤖 Gathers context:
   ├── .copilot/spec/user-auth.md                (spec — for conformance check)
   ├── .copilot/artifact/user-auth/design/        (design — for design conformance)
   ├── .copilot/artifact/user-auth/plan/           (plan — for completeness)
   ├── Changed source files                         (code)
   ├── Test files                                   (coverage check)
   └── Lint/compile errors                          (quality check)

2. 🤖 REVIEWS against checklist:
   ──────────────────────────────────────────────────────────
   ✓ Spec conformance — does code implement ALL requirements?
   ✓ Design conformance — does code follow architecture decisions?
   ✓ Contract conformance — does code match OpenAPI/AsyncAPI/JSON Schema?
   ✓ Code quality — naming, DRY, complexity, readability
   ✓ Security — secrets, input validation, SQL injection, auth
   ✓ Testing — coverage, edge cases, meaningful assertions
   ✓ DevOps — CI/CD, Docker, deployment configs
   ✓ Documentation — comments, README, API docs

3. 🤖 Produces review report:
   - Critical / Major / Minor findings
   - Positive notes (good patterns to reinforce)
   - Verdict: Approved OR Changes Requested

   If Changes Requested:
   ┌─────────────────────────────────────────────────────────┐
   │ 🤖 Shows handoff: [Address Feedback] → @Developer       │
   │ 👤 You click → Developer fixes → Tester retests →       │
   │    → Reviewer re-reviews → loop until Approved           │
   └─────────────────────────────────────────────────────────┘

   If Approved:
   🤖 Shows handoff: [Log Changes]
```

**Artifacts produced:**

| File | Content |
|------|---------|
| `.copilot/artifact/user-auth/review/user-auth-review.md` | Full review with findings, positives, verdict |

---

### Step 9: Logging — `@CopilotLogger` via `/log` or handoff

| | Detail |
|---|---|
| **You do** | Click `[Log Changes]` handoff **or** type `/log user-auth` |
| **Model** | GPT-4.1 |
| **Pre-condition** | None (terminal step) |

**Agent workflow:**

```
1. 🤖 Gathers session context:
   ├── Conversation history
   ├── All artifacts in .copilot/artifact/user-auth/
   └── File system search for modified files

2. 🤖 Compiles worklog:
   - Per-agent activity summary (what each agent did)
   - Files changed (created / modified / deleted)
   - Artifacts produced (with links)
   - Test results and coverage
   - Document cross-references (verifies all artifacts exist)

3. 🤖 Writes worklog
   ✅ FLOW COMPLETE
```

**Artifacts produced:**

| File | Content |
|------|---------|
| `.copilot/artifact/user-auth/worklog/user-auth-worklog.md` | Full session log with per-agent activity, metrics, artifact inventory |

---

### Complete Artifact Map (After Full Flow)

After running all 9 steps, the file tree looks like:

```
.copilot/
├── context/
│   ├── overview.md                              # Unchanged (human-maintained)
│   └── constraints.md                           # Updated by Researcher with new decisions
├── spec/
│   └── user-auth.md                             # status: approved (Step 1)
│
└── artifact/user-auth/
    ├── research/                                 # Step 2
    │   ├── compute-platform.md                   #   ToT analysis
    │   ├── database-model.md                     #   Conceptual ERD
    │   └── recommendation.md                     #   Binding decisions (Status: Approved)
    ├── design/                                   # Step 3
    │   ├── user-auth.md                          #   Design doc + DB DDL
    │   └── contracts/                            #   (if API surface)
    │       ├── openapi.yaml
    │       └── schemas/
    │           └── user.schema.json
    ├── plan/                                     # Step 4
    │   └── user-auth.md                          #   Task breakdown
    ├── review/                                   # Step 8
    │   └── user-auth-review.md                   #   Review verdict
    └── worklog/                                  # Step 9
        └── user-auth-worklog.md                  #   Session log

impl/src/     ← Production code (Step 5)
test/unit/    ← Unit tests (Step 5)
test/integration/  ← Integration tests (Step 6)
test/contract/     ← Contract tests (Step 6)
```

---

### Workflow Variants

#### Quick bug fix (skip research + design)

```
1. /spec BUG-1234         → 🤖 Product asks "Feature or Bug?" → you say Bug
                             🤖 Writes bug spec: steps to reproduce, expected vs actual,
                                severity, root cause hypothesis
                             👤 Approve
2. /plan BUG-1234         → 🤖 Planner reads spec, writes fix plan
                             👤 Review, click [Start Implementation]
3. /code BUG-1234         → 🤖 Developer implements fix + unit tests + runs tests
4. /test BUG-1234         → 🤖 Tester writes integration tests, runs full suite
                             ↕ Loop with Developer if failures
5. /review BUG-1234       → 🤖 Reviewer reviews fix against spec
6. /log BUG-1234          → 🤖 Logger writes worklog ✅
```

#### Trivial fix (quickfix shortcut)

```
1. /quickfix fix-typo     → 🤖 Developer checks: <50 LOC? No new API? No arch decisions?
                             ✓ Qualifies → inline plan + implement + test in one shot
                             ✗ Too complex → STOPS, suggests full /spec → /plan → /code flow
```

#### Standalone review (no spec)

```
Switch to @Reviewer directly in chat, point to files or a PR.
🤖 Reviews against coding standards, security, quality.
📝 Report goes to .copilot/artifact/reviews/<timestamp>-<topic>.md
```

#### Registry update (index all specs)

```
/registry               → 🤖 Product scans all .copilot/spec/*.md
                           Reads frontmatter from each
                           Checks which artifacts exist (design, plan, review, worklog)
                           📝 Writes .copilot/spec/REGISTRY.md (summary + full table)
```

---

## Gate Summary

| Agent | Pre-Condition Gate (Step 0) | Approval Gate | What Blocks |
|-------|---------------------------|---------------|-------------|
| `@Product` | — | Approve / Request Changes | Handoff buttons hidden until approved |
| `@Researcher` | Spec `status: approved` | Approve / Request Changes | Handoff buttons hidden until approved |
| `@Architect` | Spec `status: approved` + research `Status: Approved` (if exists) | Approve / Request Changes | Handoff buttons hidden until approved |
| `@Planner` | Spec `status: approved` + design approved (if exists) | User reviews plan | Handoff to Developer |
| `@Developer` | Spec `status: approved` + plan exists | Self-verify (tests + lint) | Handoff to Tester |
| `@Tester` | — | All tests must pass | Loops back to Developer on failure |
| `@DevOps` | — | — | — |
| `@Reviewer` | — | Approved / Changes Requested | Loops back to Developer on changes |
| `@CopilotLogger` | — | — | Terminal node |

---

## Spec-Driven Development Alignment

This setup follows **Spec-Driven Development (SDD)** principles:

| SDD Principle | How We Implement It |
|---------------|-------------------|
| Spec before code | `/spec` → `/code` flow enforced; gate checks verify `status: approved` |
| Technology evaluation | `/research` uses Tree-of-Thought analysis; preferences built incrementally via user questions |
| Machine-readable contracts | Architect produces OpenAPI/AsyncAPI/JSON Schema when API surface exists |
| Database modeling | Researcher produces conceptual ERD; Architect refines into physical schema (DDL, indexes, migrations) |
| Artifact traceability | `spec_id` threads all artifacts: spec → research → design → contracts → plan → code → tests → review → worklog |
| Spec conformance testing | Tester validates implementation against contracts; Reviewer includes spec conformance checklist |
| Cross-model review | Reviewer uses a different model family than Developer to catch blind spots |
| Approval gates | Product, Researcher, Architect ask explicit Approve/Request Changes via `askQuestions`; handoff buttons shown only after approval |
| Pre-condition gates | Each agent checks upstream artifact status before starting work |
| Binding research decisions | Researcher's `recommendation.md` is treated as binding constraints by Architect — not re-evaluated |
| Feedback loop | Developer flags spec gaps during implementation instead of silently working around them |
| Spec catalogue | `/registry` prompt generates an index of all specs with status and linked artifacts |
| Preference management | `.copilot/context/constraints.md` organized by layers (Infra, Backend, Frontend, Data, etc.) with Quick Reference table and Decision Log |

---

## Adopting in Other Repos

1. **Copy the `.github/` folder** into your repo.
2. **Copy the `.copilot/context/` folder** — update `overview.md` with your project details; clear `constraints.md`.
3. **Adjust instruction globs** if your project structure differs (e.g., different source folders).
4. **Update `impl/` references** in agent files if your project uses a different source root.

---

## Troubleshooting

- **Prompts not showing?** — Type `/` in chat. If missing, check `chat.promptFilesLocations` in settings.
- **Agent not found?** — Type `@` in chat. Check **Configure Chat > Diagnostics** for errors.
- **Instructions not applied?** — Check the `applyTo` glob matches your file. Use **Configure Chat > Diagnostics**.
- **Wrong model?** — The prompt's `model:` overrides the model picker. The agent's `model:` is used when invoking the agent directly (without a prompt).
- **Input dialog not appearing?** — Ensure your VS Code version supports `${input:variableName}` in prompt files.
- **Gate check failing?** — Verify the upstream artifact exists and has the correct `status` in its YAML frontmatter.



---

## Knowledge Graph Integration

This setup integrates **graphify** for efficient, graph-based codebase navigation. Instead of repeatedly scanning files, agents read a generated knowledge graph to understand code structure, relationships, and impact.

### Benefits

- **Faster exploration** — Read pre-analyzed architecture instead of scanning files
- **Better context** — See "God Nodes" (highly connected code) and "Surprising Connections"
- **Community detection** — Automatically identified modules and their relationships
- **Visual navigation** — Interactive HTML visualization of the codebase
- **Plain-language reports** — Architecture summaries in markdown

### How It Works

```
Agents → graphify-out/GRAPH_REPORT.md → Knowledge Graph
                                       (updated via git hooks)
```

### Quick Start

1. **Generate the graph**:
   In VSCode Copilot Chat, type: `/graphify`

2. **View the results**:
   - Open `graphify-out/GRAPH_REPORT.md` for architecture summary
   - Open `graphify-out/graph.html` in browser for interactive visualization

3. **Agents automatically use the graph** — no manual action needed!

### Graph-First Navigation

All agents follow a **graph-first** approach — before diving into individual files, consult the knowledge graph to understand the codebase's structure and relationships:

```
1. Read graphify-out/GRAPH_REPORT.md    ← Start here: architecture overview, communities
2. Browse graphify-out/wiki/            ← Per-module details and relationships
3. graphify query "<question>"          ← BFS traversal for specific cross-cutting questions
4. Fall back to direct file reading only when the graph doesn't have what you need
```

### Example: Developer Implementing a Feature

```
Task: "Add rate limiting to API"

1. Read graphify-out/GRAPH_REPORT.md
   → See middleware community, API route structure, God Nodes

2. Browse graphify-out/wiki/middleware.md
   → Understand existing middleware chain and dependencies

3. graphify query "what routes exist in the API"
   → Returns: all API routes that need rate limiting applied

4. Read middleware.py, api_routes.py directly
   → Needed only for implementation details not covered by the graph
```

### Graph Navigation Reference

| Approach | Purpose | When to Use |
|----------|---------|-------------|
| Read `GRAPH_REPORT.md` | Architecture overview, God Nodes, communities | **Always start here** |
| Browse `wiki/<module>.md` | Per-module details, public interfaces, dependencies | Understanding a specific area |
| `graphify query "<question>"` | BFS traversal — broad context across the graph | Specific cross-cutting questions |
| `graphify . --update` | Re-analyze new/changed files incrementally | After significant code changes |
| Direct file reading | Line-level implementation detail | When graph output isn't specific enough |

### Automatic Graph Updates

The graph stays synchronized via git hooks:

- **After commits**: Runs `graphify . --update --no-viz`
- **After merges**: Runs `graphify . --update --no-viz`

### Documentation

- **[skills/graphify.skill.md](skills/graphify.skill.md)** — Full setup guide, usage, and Copilot skill documentation
- **[instructions/copilot.instructions.md](instructions/copilot.instructions.md)** — General Copilot behavior instructions

### Agent Integration

All agents now use graphify:

- **Developer**: Reads `GRAPH_REPORT.md` for architecture overview before implementing
- **Reviewer**: Uses graph to understand change impact and dependencies
- **Tester**: Uses graph to identify test coverage gaps
- **Discovery**: Uses graph for architecture documentation generation

### Troubleshooting

**Graphify not installed?**
```bash
# Install graphify
uv tool install graphifyy

# Or with pip
python -m pip install graphifyy
```

**Graph out of date?**
```bash
# Update the graph
graphify . --update

# Or rebuild from scratch
rm -rf graphify-out/
graphify .
```

See [skills/graphify.skill.md](skills/graphify.skill.md) for detailed setup and troubleshooting.

---
