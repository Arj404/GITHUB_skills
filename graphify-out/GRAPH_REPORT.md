# Graph Report - .  (2026-04-26)

## Corpus Check
- Corpus is ~32,368 words - fits in a single context window. You may not need a graph.

## Summary
- 230 nodes · 422 edges · 13 communities detected
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]

## God Nodes (most connected - your core abstractions)
1. `fix_blanks.py — Normalize blank lines in any file.  Rules applied to the entire` - 1 edges

## Surprising Connections (you probably didn't know these)
- `Developer Agent` --reads_source_root_from--> `Copilot Context: Project Paths`  [INFERRED]
   →   _Bridges community 2 → community 4_
- `Cross-Model Review Strategy` --differs_from--> `Claude Sonnet 4.6 Model`  [INFERRED]
   →   _Bridges community 2 → community 1_
- `MODEL_STRATEGY.md` --assigns_to_requirements_and_design--> `Claude Opus 4.6 Model`  [EXTRACTED]
   →   _Bridges community 1 → community 4_
- `README.md` --references--> `CONTRIBUTING.md`  [EXTRACTED]
   →   _Bridges community 1 → community 3_
- `CONTRIBUTING.md` --describes_how_to_add--> `Product Agent`  [EXTRACTED]
   →   _Bridges community 3 → community 4_

## Hyperedges (group relationships)
- **Requirements & Design Model Group** — agent_product, agent_researcher, agent_architect, agent_discovery, model_claude_opus_46 [INFERRED]
- **Implementation Model Group** — agent_planner, agent_developer, agent_tester, agent_migrator, agent_security_auditor, model_claude_sonnet_46 [INFERRED]
- **Universal Instructions (applyTo all files)** — instr_copilot, instr_coding_standard, instr_review [INFERRED]
- **Full New Feature Workflow Chain** — prompt_spec, prompt_research, prompt_design, prompt_plan, prompt_migrate, prompt_code, prompt_test, prompt_audit, prompt_cicd, prompt_review, prompt_log [INFERRED]
- **CI Quality Gate Toolchain** — tool_ruff, tool_eslint, tool_golangci_lint, tool_sqlfluff, tool_trivy, instr_quality [INFERRED]
- **Full Agent Development Pipeline** —  [EXTRACTED]
- **Security Compliance Standards Triad** —  [EXTRACTED]
- **Spec-Gated Artifact Chain** —  [EXTRACTED]
- **Graphify Knowledge Graph Auto-Update Cycle** —  [EXTRACTED]
- **Test Directory Hierarchy** —  [EXTRACTED]
- **Core Development Workflow Pipeline** —  [EXTRACTED]
- **Artifact Dependency Chain** —  [EXTRACTED]
- **Graphify Output Trio** —  [EXTRACTED]
- **Product Agent Prompt Group** —  [EXTRACTED]

## Communities

### Community 0 - "Community 0"
Cohesion: 0.0
Nodes (41): Architect Agent, Audit Prompt, CI/CD Pipeline, CI/CD Prompt, Code Prompt, .copilot/context/constraints.md, CopilotLogger Agent, Design Artifact (+33 more)

### Community 1 - "Community 1"
Cohesion: 0.0
Nodes (40): CopilotLogger Agent, DevOps Agent, Reviewer Agent, Review Findings, Session Worklog, CHANGELOG.md, CHEATSHEET.md, Checkov IaC Scanner (+32 more)

### Community 2 - "Community 2"
Cohesion: 0.0
Nodes (38): Arrange-Act-Assert Pattern, Developer Agent, Migrator Agent, Planner Agent, SecurityAuditor Agent, Tester Agent, Migration Scripts, Plan Artifact (+30 more)

### Community 3 - "Community 3"
Cohesion: 0.0
Nodes (35): Alembic, Design Artifact, Graphify Knowledge Graph Output, WCAG 2.1 AA Accessibility, URI Path Versioning Strategy, CQRS Pattern, API Deprecation Lifecycle, Material Design System (+27 more)

### Community 4 - "Community 4"
Cohesion: 0.0
Nodes (32): Architecture Decision Records (ADRs), Architect Agent, Discovery Agent, Product Agent, Researcher Agent, Architecture Principles Instructions, Discovery Documentation (docs/), Spec Registry (.copilot/spec/REGISTRY.md) (+24 more)

### Community 5 - "Community 5"
Cohesion: 0.0
Nodes (12): CI/CD Pipeline Stages, Infrastructure as Code, Multi-Stage Docker Builds, OpenTelemetry Distributed Tracing, OWASP Top 10, RED/USE Metrics, Structured JSON Logging, devops.instructions.md (+4 more)

### Community 6 - "Community 6"
Cohesion: 0.0
Nodes (11): BFS Graph Traversal, Community Detection, God Nodes, graph.html Visualization, graph.json (GraphRAG), GRAPH_REPORT.md, graphify Python Library, Graphify Pipeline (+3 more)

### Community 7 - "Community 7"
Cohesion: 0.0
Nodes (6): git-hooks/ Directory, Git Hooks README, graphify-out/ Knowledge Graph Output, Knowledge Graph Auto-Update Workflow, post-commit Git Hook, post-merge Git Hook

### Community 8 - "Community 8"
Cohesion: 0.0
Nodes (4): Discover Prompt, Discovery Agent, Mermaid Diagrams, Three-Layer Product Documentation

### Community 9 - "Community 9"
Cohesion: 0.0
Nodes (1): fix_blanks.py — Normalize blank lines in any file.  Rules applied to the entire

### Community 10 - "Community 10"
Cohesion: 0.0
Nodes (3): Java Coding Standards Instructions, Maven/Gradle Build Tools, Spring Boot

### Community 11 - "Community 11"
Cohesion: 0.0
Nodes (3): Cargo (Rust Toolchain), Rust Coding Standards Instructions, Tokio Async Runtime

### Community 12 - "Community 12"
Cohesion: 0.0
Nodes (2): Agent Handoff Flow, Pre-Condition Approval Gates

## Knowledge Gaps
- **1 isolated node(s):** `fix_blanks.py — Normalize blank lines in any file.  Rules applied to the entire`
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `Community 12`** (2 nodes): `Agent Handoff Flow`, `Pre-Condition Approval Gates`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.