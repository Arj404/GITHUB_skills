---
description: Create or update CI/CD pipelines, Dockerfiles, and deployment configs
agent: DevOps
model: Gemini 3.1 Pro (Preview)
argument-hint: 'Enter spec_id (e.g., user-auth)'
---

The **spec_id** is: `${input:spec_id:Spec ID e.g. user-auth}`

Set up or update **CI/CD, Docker, and deployment** automation for this implementation.

- Read the spec from `.copilot/spec/${input:spec_id}.md` for context.
- Read the plan from `.copilot/artifact/${input:spec_id}/plan/` if it exists.
- Scan existing pipelines, Dockerfiles, IaC files, and scripts before making changes.
- Pipeline stages: lint → build → test → security scan → deploy. All gates must pass.
- Validate configs (`terraform validate`, `docker build`, YAML syntax) before presenting.
- Document setup, deploy, and rollback instructions.
