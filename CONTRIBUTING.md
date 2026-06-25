# Contributing Guide

Thank you for contributing to the GitHub Copilot Custom Setup framework. This guide explains how to add, modify, or remove agents, instructions, prompts, and skills, and describes the review expectations for each.

---

## Table of Contents

- [Folder Structure Primer](#folder-structure-primer)
- [Adding an Agent](#adding-an-agent)
- [Adding an Instruction](#adding-an-instruction)
- [Adding a Prompt](#adding-a-prompt)
- [Adding a Skill](#adding-a-skill)
- [Modifying Existing Artifacts](#modifying-existing-artifacts)
- [Review Checklist](#review-checklist)
- [Commit Conventions](#commit-conventions)

---

## Folder Structure Primer

```
agents/           # AI personas — who does the work and how
instructions/     # Auto-applied coding/process rules (by file glob)
prompts/          # Slash commands that invoke an agent with a brief
skills/           # Specialized self-contained capabilities (/trigger commands)
```

All four artifact types are **independent files**. They cross-reference each other through relative paths inside their markdown content — there is no registry file to update manually (run `/registry` to regenerate).

---

## Adding an Agent

An agent is a persistent AI persona. Create it when you need a distinct role with its own tools, output path, and handoff logic.

### Steps

1. **Create the file** in `agents/` using the naming convention `<RoleName>.agent.md`  
   Example: `agents/DataEngineer.agent.md`

2. **Add YAML frontmatter:**

   ```yaml
   ---
   name: DataEngineer
   description: >-
     Data Engineer — designs and implements data pipelines,
     transformations, and warehouse schemas.
   argument-hint: Describe the data pipeline or schema change
   model: Claude Sonnet 4.6          # see MODEL_STRATEGY.md for options
   tools: ['agent', 'edit', 'search', 'read', 'execute', 'vscode/askQuestions']
   agents: []
   handoffs: []
   ---
   ```

3. **Write the agent body** covering:
   - Role definition (one paragraph)
   - Pre-condition gate checks (what upstream artifacts must exist)
   - Step-by-step workflow (numbered, include `🤖` / `👤` markers)
   - Artifacts produced (table: path → content)
   - Handoff buttons (what appears after the agent completes)
   - References to instructions it follows

4. **Update `README.md`** — add a row to the Agents table and the Handoff Flow diagram.

5. **Add a prompt** (optional but recommended) so users can invoke the agent directly — see [Adding a Prompt](#adding-a-prompt).

### Checklist

- [ ] Frontmatter is valid YAML with `name`, `description`, `argument-hint`, `model`, `tools`, `agents`, `handoffs`
- [ ] Pre-condition gates are explicit (spec status, upstream artifact status)
- [ ] Output path follows the `.copilot/artifact/<spec_id>/` convention
- [ ] Handoff buttons are defined
- [ ] README.md agents table is updated

---

## Adding an Instruction

An instruction is an auto-applied rule set scoped to a file-type glob. Create one when you have a new language, framework, or process standard that should apply automatically.

### Steps

1. **Create the file** in `instructions/` using the naming convention:
   - Language rules: `coding.<language>.instructions.md`  
     Example: `instructions/coding.ruby.instructions.md`
   - Process rules: `<topic>.instructions.md`  
     Example: `instructions/observability.instructions.md`

2. **Add YAML frontmatter** with an `applyTo` glob:

   ```yaml
   ---
   applyTo: "**/*.rb"
   ---
   ```

   For process rules that span all files:

   ```yaml
   ---
   applyTo: "**"
   ---
   ```

3. **Write the rules** — use short, declarative sentences. Group by topic with `##` headings. Add a `## References` section linking to related instructions.

4. **Register in `vscode/settings.json`** if the instruction should always be loaded (vs. only when the file type is matched):

   ```json
   {
     "github.copilot.chat.codeGeneration.instructions": [
       { "file": "instructions/coding.ruby.instructions.md" }
     ]
   }
   ```

5. **Update `README.md`** — add a row to the Instructions table.

### Checklist

- [ ] `applyTo` glob is correct and not overly broad
- [ ] Rules are actionable, not vague ("use X" not "consider X")
- [ ] No duplicate rules already covered by `coding.standard.instructions.md`
- [ ] `## References` links to related instruction files
- [ ] README.md instructions table is updated

---

## Adding a Prompt

A prompt is a slash command that invokes an agent with a specific brief. Create one when you have a repeatable task that doesn't warrant a new agent persona.

### Steps

1. **Create the file** in `prompts/` using `<command>.prompt.md`  
   Example: `prompts/diagram.prompt.md`

2. **Add YAML frontmatter:**

   ```yaml
   ---
   description: Generate architecture diagrams for a spec
   agent: Planner
   argument-hint: 'Enter spec_id (e.g., user-auth)'
   model: Claude Sonnet 4.6   # optional — override only when a specific model is required; see MODEL_STRATEGY.md
   ---
   ```

   The `model:` field is optional. Omit it to use the agent's default model. Only override when the task has specific model requirements (e.g., a long-context or vision task). See [MODEL_STRATEGY.md](../MODEL_STRATEGY.md) for approved model names.

3. **Write the prompt body:**

   ```markdown
   Your task: generate Mermaid architecture diagrams for spec `${input:spec_id}`.

   Switch to @Planner mode and follow the Planner agent instructions.

   Inputs:
   - .copilot/spec/${input:spec_id}.md
   - .copilot/artifact/${input:spec_id}/research/

   Output: .copilot/artifact/${input:spec_id}/diagrams/
   ```

4. **Update `README.md`** — add a row to the Prompt Reference table including the agent it delegates to and the model it uses.

### Checklist

- [ ] Uses `${input:spec_id}` for consistent spec threading
- [ ] Delegates to an existing named agent (`@AgentName`)
- [ ] Output path follows the `.copilot/artifact/<spec_id>/` convention
- [ ] README.md prompt table is updated

---

## Adding a Skill

A skill is a self-contained slash command with its own detailed execution instructions. Unlike prompts (which delegate to agents), skills define their own step-by-step procedures inline.

See [skills/README.md](skills/README.md) for full guidance on skill creation, frontmatter format, and how to register skills in `vscode/settings.json`.

### Quick checklist

- [ ] File lives in `skills/` with a `.skill.md` suffix
- [ ] Frontmatter includes `name`, `description`, `trigger`
- [ ] Instructions are self-contained (no implicit agent dependency)
- [ ] Registered in `vscode/settings.json`
- [ ] `skills/README.md` Available Skills section is updated

---

## Modifying Existing Artifacts

- **Instructions**: changing an `applyTo` glob affects every file type that glob matches — validate the scope before merging.
- **Agents**: changing pre-condition gates or handoff buttons affects the entire workflow chain — update the README Handoff Flow diagram.
- **Prompts**: changing the model requires a corresponding update to the README Prompt Reference table and MODEL_STRATEGY.md.
- **Skills**: changing a trigger command is a breaking change for anyone who has the command memorised — note it in CHANGELOG.md.

---

## Review Checklist

All PRs to this repository must pass:

- [ ] YAML frontmatter in all changed files is valid
- [ ] No hardcoded model names in agent/prompt files (use the names defined in MODEL_STRATEGY.md)
- [ ] README.md tables reflect the change
- [ ] CHANGELOG.md has an entry under `## [Unreleased]`
- [ ] At least one test run of the new agent/prompt/skill confirms it behaves as described
- [ ] No secrets, tokens, or real API keys appear anywhere

---

## Commit Conventions

Follow the [Conventional Commits](https://www.conventionalcommits.org/) standard:

| Type | When to use |
|------|------------|
| `feat:` | New agent, instruction, prompt, or skill |
| `fix:` | Correcting broken logic, wrong glob, bad gate check |
| `docs:` | README, CONTRIBUTING, CHANGELOG updates only |
| `refactor:` | Restructuring without behavior change |
| `chore:` | Settings, tooling, non-functional updates |

**Examples:**

```
feat: add DataEngineer agent with pipeline planning workflow
fix: correct applyTo glob in coding.ruby.instructions.md
docs: update README handoff diagram for DataEngineer
chore: register new skill in vscode/settings.json
```
