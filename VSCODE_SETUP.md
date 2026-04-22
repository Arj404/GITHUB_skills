# VSCode Setup Guide for Code Graph Integration

This guide explains how to set up the code-review-graph MCP integration for VSCode (GitHub Copilot).

## Overview

The code-review-graph integration works with:
1. **Kiro IDE** — Uses `.kiro/settings/mcp.json`
2. **VSCode with GitHub Copilot** — Uses `.vscode/mcp.json` or `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json`

## VSCode Configuration Options

### Option 1: Workspace-Level Configuration (Recommended)

This configuration applies only to this workspace.

**File**: `.vscode/mcp.json` (already created)

```json
{
  "mcpServers": {
    "code-review-graph": {
      "command": "uvx",
      "args": [
        "code-review-graph",
        "serve"
      ],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

### Option 2: User-Level Configuration (Global)

This configuration applies to all VSCode workspaces.

**macOS**: `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json`

**Linux**: `~/.config/Code/User/globalStorage/github.copilot-chat/mcp.json`

**Windows**: `%APPDATA%\Code\User\globalStorage\github.copilot-chat\mcp.json`

Create the file with the same content as above.

## Prerequisites

### 1. Install uv and uvx

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Or via Homebrew (macOS)
brew install uv

# Or via pip
pip install uv

# Verify installation
uvx --version
```

### 2. Install code-review-graph

```bash
# The uvx command will automatically download and run code-review-graph
# No separate installation needed!

# Test it works
uvx code-review-graph --help
```

### 3. Generate the Code Graph

```bash
# Initialize the graph (creates .code-graph/ directory)
code-review-graph init

# Build the graph from your codebase
code-review-graph update

# Check status
code-review-graph status
```

## VSCode Settings Configuration

The `.vscode/settings.json` file has been updated to include code-graph instructions:

```json
{
    "kiroAgent.configureMCP": "Disabled",
    "github.copilot.chat.codeGeneration.instructions": [
        {
            "file": "../instructions/code-graph.instructions.md"
        }
    ],
    "github.copilot.chat.useProjectTemplates": true
}
```

This ensures GitHub Copilot reads the code-graph navigation standards.

## Verify Setup

### 1. Check MCP Server Connection

In VSCode:
1. Open Command Palette (`Cmd+Shift+P` on macOS, `Ctrl+Shift+P` on Windows/Linux)
2. Search for "GitHub Copilot: Show MCP Servers"
3. Look for "code-review-graph" in the list
4. Status should show as "Connected" or "Running"

### 2. Test Graph Tools

Open GitHub Copilot Chat and try:

```
@workspace Can you use the code graph to show me the architecture overview?
```

Copilot should use the `get_architecture_overview` tool from the MCP server.

### 3. Test with Specific Queries

```
@workspace Use the graph to find all functions related to authentication

@workspace What's the impact radius of changing the User model?

@workspace Show me what tests cover the payment processing code
```

## Available Tools in VSCode

Once configured, GitHub Copilot can use these graph tools:

| Tool | Purpose |
|------|---------|
| `get_minimal_context` | Get focused context for a task |
| `semantic_search_nodes` | Find functions/classes by name |
| `query_graph` | Trace relationships (callers, imports, tests) |
| `get_impact_radius` | Understand blast radius of changes |
| `get_affected_flows` | See impacted execution paths |
| `detect_changes` | Risk-scored change analysis |
| `get_architecture_overview` | High-level structure |
| `list_communities` | Major modules |
| `find_large_functions` | Identify complex code |
| `get_review_context` | Token-efficient source snippets |

## Using Graph Tools in VSCode

### Example 1: Exploring Code

```
@workspace I need to understand how authentication works. 
Use the code graph to explore the auth module.
```

Expected: Copilot uses `get_minimal_context` and `semantic_search_nodes`

### Example 2: Impact Analysis

```
@workspace I'm about to change the User model. 
Use the graph to show me what will be affected.
```

Expected: Copilot uses `get_impact_radius` and `get_affected_flows`

### Example 3: Finding Tests

```
@workspace Use the graph to find all tests that cover the payment processing code.
```

Expected: Copilot uses `query_graph(pattern="tests_for")`

### Example 4: Code Review

```
@workspace Review my recent changes using the code graph to analyze impact.
```

Expected: Copilot uses `detect_changes` and `get_review_context`

## Automatic Graph Updates

### For VSCode Users

Unlike Kiro which has built-in hooks, VSCode requires manual graph updates or external automation.

#### Option A: Manual Updates (Simple)

After making significant changes:

```bash
code-review-graph update
```

#### Option B: Git Hooks (Automated)

Create `.git/hooks/post-commit`:

```bash
#!/bin/bash
# Auto-update code graph after commits
code-review-graph update --skip-flows
```

Make it executable:

```bash
chmod +x .git/hooks/post-commit
```

#### Option C: File Watcher (Advanced)

Use a file watcher tool like `watchman` or `fswatch`:

```bash
# macOS with fswatch
brew install fswatch

# Watch for changes and update graph
fswatch -o src/ | xargs -n1 -I{} code-review-graph update --skip-flows
```

#### Option D: VSCode Task (Recommended)

Create `.vscode/tasks.json`:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Update Code Graph",
            "type": "shell",
            "command": "code-review-graph update --skip-flows",
            "problemMatcher": [],
            "presentation": {
                "reveal": "silent",
                "panel": "shared"
            }
        },
        {
            "label": "Check Code Graph Status",
            "type": "shell",
            "command": "code-review-graph status",
            "problemMatcher": []
        }
    ]
}
```

Run via Command Palette: "Tasks: Run Task" → "Update Code Graph"

Or bind to a keyboard shortcut in `.vscode/keybindings.json`:

```json
[
    {
        "key": "cmd+shift+g",
        "command": "workbench.action.tasks.runTask",
        "args": "Update Code Graph"
    }
]
```

## Differences: Kiro vs VSCode

| Feature | Kiro IDE | VSCode |
|---------|----------|--------|
| MCP Config | `.kiro/settings/mcp.json` | `.vscode/mcp.json` or user-level |
| Auto-update | Built-in hooks | Manual or external automation |
| Instructions | Auto-loaded from `.kiro/` | Loaded via `settings.json` |
| Tool approval | Auto-approved in config | Copilot prompts for approval |
| Integration | Native | Via GitHub Copilot Chat |

## Troubleshooting

### MCP Server Not Showing in VSCode

1. **Check file location**:
   ```bash
   # Workspace-level
   ls -la .vscode/mcp.json
   
   # User-level (macOS)
   ls -la ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json
   ```

2. **Verify JSON syntax**:
   ```bash
   # Check for syntax errors
   cat .vscode/mcp.json | python -m json.tool
   ```

3. **Restart VSCode**:
   - Close all VSCode windows
   - Reopen the workspace
   - Check MCP servers again

4. **Check uvx is in PATH**:
   ```bash
   which uvx
   # Should show path like /Users/username/.local/bin/uvx
   ```

5. **Test MCP server manually**:
   ```bash
   uvx code-review-graph serve
   # Should start the server without errors
   ```

### Graph Out of Date

```bash
# Update the graph
code-review-graph update

# Force full rebuild
code-review-graph update --force

# Check status
code-review-graph status
```

### Copilot Not Using Graph Tools

1. **Explicitly ask Copilot to use the graph**:
   ```
   @workspace Use the code-review-graph MCP tools to explore the codebase
   ```

2. **Check instructions are loaded**:
   - Open `.vscode/settings.json`
   - Verify `github.copilot.chat.codeGeneration.instructions` includes code-graph.instructions.md

3. **Reload VSCode window**:
   - Command Palette → "Developer: Reload Window"

### Permission Issues

```bash
# Make sure uvx is executable
chmod +x ~/.local/bin/uvx

# Check code-review-graph can access the codebase
code-review-graph status
```

## Best Practices for VSCode

### 1. Update Graph Regularly

```bash
# Before starting work
code-review-graph update

# After major changes
code-review-graph update

# Check status periodically
code-review-graph status
```

### 2. Use Explicit Instructions

When asking Copilot to use the graph, be explicit:

✅ **Good**:
```
@workspace Use the code graph to find all callers of the authenticate function
```

❌ **Less effective**:
```
@workspace Find callers of authenticate
```

### 3. Combine with Traditional Tools

The graph is great for structure, but sometimes you need file content:

```
@workspace Use the graph to find the User model, then show me its implementation
```

### 4. Leverage Graph for Reviews

```
@workspace Use detect_changes to analyze my recent commits and show impact
```

## Integration with GitHub Copilot Agents

If you're using custom GitHub Copilot agents (similar to the Kiro agents), you can reference the code-graph instructions:

In your agent configuration:

```markdown
## Instructions

Follow these shared standards:
- [Code Graph Navigation](../instructions/code-graph.instructions.md) for efficient codebase exploration
- ...
```

## Performance Tips

### 1. Use Minimal Detail Level

When asking Copilot to query the graph:

```
@workspace Use get_minimal_context with detail_level="minimal" to understand the auth module
```

### 2. Start Broad, Then Narrow

```
@workspace First use get_architecture_overview, then drill into the auth community
```

### 3. Combine Multiple Queries

```
@workspace Use the graph to:
1. Find the User model
2. Show its callers
3. Find tests that cover it
```

## Advanced Configuration

### Custom Environment Variables

Add to `.vscode/mcp.json`:

```json
{
  "mcpServers": {
    "code-review-graph": {
      "command": "uvx",
      "args": ["code-review-graph", "serve"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "CODE_GRAPH_DB_PATH": ".code-graph/graph.db",
        "CODE_GRAPH_CACHE_SIZE": "1000"
      }
    }
  }
}
```

### Multiple Workspaces

If you have multiple workspace folders, each can have its own `.vscode/mcp.json`:

```
workspace-root/
├── project-a/
│   └── .vscode/
│       └── mcp.json
├── project-b/
│   └── .vscode/
│       └── mcp.json
└── workspace.code-workspace
```

## Resources

- **[CODE_GRAPH_INTEGRATION.md](CODE_GRAPH_INTEGRATION.md)** — Complete integration guide
- **[code-graph/QUICK_REFERENCE.md](code-graph/QUICK_REFERENCE.md)** — Quick reference
- **[instructions/code-graph.instructions.md](instructions/code-graph.instructions.md)** — Detailed standards
- **[GitHub Copilot MCP Documentation](https://docs.github.com/en/copilot/using-github-copilot/using-extensions-to-integrate-external-tools-with-copilot-chat)** — Official MCP docs

## Summary

VSCode setup is now complete:

✅ **Created**: `.vscode/mcp.json` — MCP server configuration
✅ **Updated**: `.vscode/settings.json` — Copilot instructions
✅ **Available**: All code-graph tools via GitHub Copilot Chat

**Next steps**:
1. Verify uvx is installed: `uvx --version`
2. Generate the graph: `code-review-graph init && code-review-graph update`
3. Test in Copilot Chat: `@workspace Use the graph to show architecture overview`
4. Set up automatic updates (git hooks or VSCode tasks)

The graph-powered navigation is now available in both Kiro IDE and VSCode!
