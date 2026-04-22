---
title: Code Graph Navigation Standards
description: Standards for using the code-review-graph MCP tools to efficiently explore and understand the codebase
applies-to: all
---

# Code Graph Navigation Standards

**IMPORTANT: This project has a knowledge graph. ALWAYS use the code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore the codebase.** The graph is faster, cheaper (fewer tokens), and gives you structural context (callers, dependents, test coverage) that file scanning cannot.

## Core Principle

**Graph-First Navigation**: Before reading any files or searching with grep, query the graph to understand structure, relationships, and impact. Only fall back to file reading when the graph doesn't provide what you need.

## Token Efficiency Rules

1. **ALWAYS start with `get_minimal_context(task="<your task>")` before any other graph tool.**
2. **Use `detail_level="minimal"` on all calls.** Only escalate to "standard" when minimal is insufficient.
3. **Target**: Complete any review/debug/refactor task in ≤5 tool calls and ≤800 total output tokens.

## When to Use Graph Tools FIRST

| Scenario | Use This Tool | Instead Of |
|----------|--------------|------------|
| Exploring code | `semantic_search_nodes` or `query_graph` | Grep/file search |
| Understanding impact | `get_impact_radius` | Manually tracing imports |
| Code review | `detect_changes` + `get_review_context` | Reading entire files |
| Finding relationships | `query_graph` with callers_of/callees_of/imports_of/tests_for | Manual code tracing |
| Architecture questions | `get_architecture_overview` + `list_communities` | Reading multiple files |
| Finding test coverage | `query_graph` pattern="tests_for" | Searching test directories |
| Identifying complex code | `find_large_functions` | Manual inspection |

## Key Tools Reference

### Discovery & Navigation
- **`get_minimal_context(task="...")`** — Start here! Gets focused context for your task
- **`list_graph_stats`** — Overall codebase metrics (files, functions, complexity)
- **`get_architecture_overview`** — High-level module structure and communities
- **`list_communities`** — Major modules/areas in the codebase
- **`get_community(name="...")`** — Details about a specific module/area
- **`semantic_search_nodes(query="...")`** — Find functions/classes by name or keyword

### Relationship Tracing
- **`query_graph(pattern="callers_of", node_id="...")`** — Who calls this function?
- **`query_graph(pattern="callees_of", node_id="...")`** — What does this function call?
- **`query_graph(pattern="imports_of", node_id="...")`** — What does this file import?
- **`query_graph(pattern="tests_for", node_id="...")`** — What tests cover this code?
- **`query_graph(pattern="children_of", node_id="...")`** — All functions/classes in a file

### Impact Analysis
- **`get_impact_radius(file_path="...")`** — Blast radius of changes to this file
- **`get_affected_flows(file_path="...")`** — Which execution paths are impacted
- **`detect_changes()`** — Risk-scored analysis of recent changes
- **`get_review_context(file_path="...")`** — Token-efficient source snippets for review

### Execution Flow
- **`list_flows`** — All execution paths in the codebase
- **`get_flow(flow_id="...")`** — Detailed trace of a specific execution path

### Code Quality
- **`find_large_functions(min_lines=50)`** — Identify complex functions needing refactoring
- **`refactor_tool(action="...")`** — Plan renames, find dead code

## Standard Workflows

### 1. Exploring Unfamiliar Code

```
1. get_minimal_context(task="understand authentication flow")
2. semantic_search_nodes(query="auth login")
3. query_graph(pattern="callees_of", node_id="<found_function>")
4. get_flow(flow_id="<relevant_flow>")
```

### 2. Understanding Impact of Changes

```
1. get_minimal_context(task="assess impact of changing User model")
2. get_impact_radius(file_path="src/models/user.py")
3. get_affected_flows(file_path="src/models/user.py")
4. query_graph(pattern="tests_for", node_id="src/models/user.py")
```

### 3. Code Review

```
1. detect_changes()  # Get risk-scored change analysis
2. get_review_context(file_path="<changed_file>")  # Get focused snippets
3. get_impact_radius(file_path="<changed_file>")  # Check blast radius
4. query_graph(pattern="tests_for", node_id="<changed_file>")  # Verify test coverage
```

### 4. Debugging an Issue

```
1. get_minimal_context(task="debug payment processing error")
2. semantic_search_nodes(query="payment process")
3. query_graph(pattern="callers_of", node_id="<suspect_function>")
4. get_flow(flow_id="<payment_flow>")
5. detect_changes()  # Check if recent changes caused it
```

### 5. Architecture Understanding

```
1. get_architecture_overview()
2. list_communities()
3. get_community(name="<module_of_interest>")
4. query_graph(pattern="imports_of", node_id="<module_file>")
```

## Integration with Existing Workflows

### For Developer Agent
- **Before implementing**: Use `get_minimal_context` + `semantic_search_nodes` to find relevant code
- **During implementation**: Use `query_graph` to understand dependencies and callers
- **After implementation**: Use `get_impact_radius` to verify change scope

### For Reviewer Agent
- **Start review**: Use `detect_changes` to get risk-scored analysis
- **Deep review**: Use `get_review_context` for token-efficient source access
- **Impact check**: Use `get_affected_flows` to understand execution path changes
- **Test coverage**: Use `query_graph(pattern="tests_for")` to verify testing

### For Discovery Agent
- **Phase 1 (Overview)**: Use `get_architecture_overview` + `list_graph_stats`
- **Phase 2 (Areas)**: Use `list_communities` + `get_community` for each area
- **Phase 3 (Deep Dives)**: Use `query_graph` to trace relationships within each area

### For Tester Agent
- **Finding test gaps**: Use `query_graph(pattern="tests_for")` on each module
- **Understanding coverage**: Use `get_flow` to see execution paths
- **Impact testing**: Use `get_affected_flows` to identify what needs testing

## Graph Auto-Update

The graph automatically updates when files change. You don't need to manually trigger updates — the hooks handle this:

- **PostToolUse**: After any Edit/Write/Bash command, runs `code-review-graph update --skip-flows`
- **SessionStart**: Runs `code-review-graph status` to verify graph is current

## Fallback to Traditional Tools

Use Grep/Glob/Read **only** when:
- The graph doesn't contain the information you need (e.g., searching for specific string patterns in comments)
- You need to read the actual implementation details after identifying the right location via graph
- You're working with non-code files (configs, docs, etc.)

## Rules

1. **Always query the graph before reading files** — it's faster and more informative
2. **Start with `get_minimal_context`** — it's optimized for your specific task
3. **Use minimal detail level** — only escalate when needed
4. **Combine graph tools** — use multiple queries to build complete understanding
5. **Trust the graph** — it's kept up-to-date automatically via hooks
6. **Document your graph queries** — helps others understand your exploration path

## Examples

### Bad: Traditional File Scanning
```
❌ grep -r "authenticate" src/
❌ Read src/auth/login.py
❌ Read src/auth/middleware.py
❌ grep -r "import.*login" src/
```

### Good: Graph-First Navigation
```
✅ get_minimal_context(task="understand authentication flow")
✅ semantic_search_nodes(query="authenticate")
✅ query_graph(pattern="callers_of", node_id="src/auth/login.py::authenticate")
✅ get_flow(flow_id="auth_flow")
```

The graph approach is faster, uses fewer tokens, and provides structural context that grep cannot.
