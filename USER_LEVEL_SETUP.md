# User-Level Configuration Guide

This guide explains how to set up code-review-graph integration at the **user level** (global) instead of workspace level, so it applies to all your projects.

## Overview

| Configuration | Workspace-Level | User-Level (Global) |
|--------------|-----------------|---------------------|
| **MCP Config** | `.vscode/mcp.json` | `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json` (macOS) |
| **VSCode Settings** | `.vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` (macOS) |
| **VSCode Tasks** | `.vscode/tasks.json` | Not applicable (tasks are workspace-specific) |
| **Git Hooks** | `.git-hooks/` in repo | `~/.git-templates/hooks/` (global template) |
| **Agents** | `agents/` in repo | `~/.github/agents/` or `~/.vscode/agents/` |
| **Instructions** | `instructions/` in repo | `~/.github/instructions/` or `~/.vscode/instructions/` |

## File Locations by Operating System

### Configuration Files Location Table

| Configuration | Workspace-Level | User-Level (macOS) | User-Level (Windows) |
|--------------|-----------------|-------------------|---------------------|
| **MCP Config** | `.vscode/mcp.json` | `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json` | `%APPDATA%\Code\User\globalStorage\github.copilot-chat\mcp.json` |
| **VSCode Settings** | `.vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` | `%APPDATA%\Code\User\settings.json` |
| **VSCode Tasks** | `.vscode/tasks.json` | Not applicable (tasks are workspace-specific) | Not applicable (tasks are workspace-specific) |
| **Git Hooks** | `.git-hooks/` in repo | `~/.git-templates/hooks/` | `%USERPROFILE%\.git-templates\hooks\` |
| **Agents** | `agents/` in repo | `~/.github/agents/` | `%USERPROFILE%\.github\agents\` |
| **Instructions** | `instructions/` in repo | `~/.github/instructions/` | `%USERPROFILE%\.github\instructions\` |
| **Prompts** | `prompts/` in repo | `~/.github/prompts/` | `%USERPROFILE%\.github\prompts\` |

### Expanded Paths

#### macOS

```
~/Library/Application Support/Code/User/
├── globalStorage/
│   └── github.copilot-chat/
│       └── mcp.json                    # MCP configuration
└── settings.json                        # VSCode settings

~/.github/                               # GitHub Copilot global config
├── agents/                              # Copy all *.agent.md files here
├── instructions/                        # Copy all *.instructions.md files here
└── prompts/                             # Copy all *.prompt.md files here

~/.git-templates/                        # Git global hooks template
└── hooks/
    ├── post-commit                      # Copy from .git-hooks/post-commit
    └── post-merge                       # Copy from .git-hooks/post-merge
```

#### Windows

```
%APPDATA%\Code\User\
├── globalStorage\
│   └── github.copilot-chat\
│       └── mcp.json                    # MCP configuration
└── settings.json                        # VSCode settings

%USERPROFILE%\.github\                   # GitHub Copilot global config
├── agents\                              # Copy all *.agent.md files here
├── instructions\                        # Copy all *.instructions.md files here
└── prompts\                             # Copy all *.prompt.md files here

%USERPROFILE%\.git-templates\            # Git global hooks template
└── hooks\
    ├── post-commit                      # Copy from .git-hooks\post-commit
    └── post-merge                       # Copy from .git-hooks\post-merge
```

### What to Copy Where

| Source File (Workspace) | Destination (macOS) | Destination (Windows) |
|------------------------|--------------------|-----------------------|
| `.vscode/mcp.json` | `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json` | `%APPDATA%\Code\User\globalStorage\github.copilot-chat\mcp.json` |
| `agents/*.agent.md` | `~/.github/agents/` | `%USERPROFILE%\.github\agents\` |
| `instructions/*.instructions.md` | `~/.github/instructions/` | `%USERPROFILE%\.github\instructions\` |
| `prompts/*.prompt.md` | `~/.github/prompts/` | `%USERPROFILE%\.github\prompts\` |
| `.git-hooks/post-commit` | `~/.git-templates/hooks/post-commit` | `%USERPROFILE%\.git-templates\hooks\post-commit` |
| `.git-hooks/post-merge` | `~/.git-templates/hooks/post-merge` | `%USERPROFILE%\.git-templates\hooks\post-merge` |
| `.vscode/tasks.json` | ❌ Cannot be user-level | ❌ Cannot be user-level |

### VSCode Settings Content

For user-level VSCode settings, add this to your User Settings JSON:

**Location (macOS)**: `~/Library/Application Support/Code/User/settings.json`  
**Location (Windows)**: `%APPDATA%\Code\User\settings.json`

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "text": "IMPORTANT: This project has a knowledge graph. ALWAYS use the code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore the codebase. The graph is faster, cheaper (fewer tokens), and gives you structural context (callers, dependents, test coverage) that file scanning cannot. Always start with get_minimal_context(task='your task') before any other graph tool."
    }
  ],
  "github.copilot.chat.useProjectTemplates": true
}
```

### Git Configuration

After copying git hooks to the template directory, configure git to use them:

```bash
# macOS/Linux
git config --global init.templateDir ~/.git-templates

# Windows (PowerShell)
git config --global init.templateDir "$env:USERPROFILE\.git-templates"

# Windows (CMD)
git config --global init.templateDir "%USERPROFILE%\.git-templates"
```

## Setup Instructions

### 1. MCP Configuration (User-Level)

#### macOS/Linux

```bash
# Create directory
mkdir -p ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/

# Create MCP config
cat > ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json << 'EOF'
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
EOF
```

#### Windows (PowerShell)

```powershell
# Create directory
New-Item -ItemType Directory -Force -Path "$env:APPDATA\Code\User\globalStorage\github.copilot-chat"

# Create MCP config
@"
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
"@ | Out-File -FilePath "$env:APPDATA\Code\User\globalStorage\github.copilot-chat\mcp.json" -Encoding UTF8
```

### 2. VSCode Settings (User-Level)

#### macOS/Linux

```bash
# Backup existing settings
cp ~/Library/Application\ Support/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json.backup

# Add code-graph instructions to settings
# Note: This will merge with your existing settings
```

Open VSCode:
1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type "Preferences: Open User Settings (JSON)"
3. Add this to your settings:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "text": "IMPORTANT: This project has a knowledge graph. ALWAYS use the code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore the codebase. The graph is faster, cheaper (fewer tokens), and gives you structural context (callers, dependents, test coverage) that file scanning cannot. Always start with get_minimal_context(task='your task') before any other graph tool."
    }
  ],
  "github.copilot.chat.useProjectTemplates": true
}
```

**Note**: User-level settings can't reference files from specific repos, so we use inline text instead.

### 3. Global Agents and Instructions

#### Option A: Copy to User Directory (Recommended)

```bash
# Create directories
mkdir -p ~/.github/agents
mkdir -p ~/.github/instructions
mkdir -p ~/.github/prompts

# Copy from your current repo
cp agents/*.agent.md ~/.github/agents/
cp instructions/*.instructions.md ~/.github/instructions/
cp prompts/*.prompt.md ~/.github/prompts/

# Verify
ls -la ~/.github/agents/
ls -la ~/.github/instructions/
```

#### Option B: Symlink (Advanced)

```bash
# Create symlinks to your repo
ln -s /path/to/your/repo/agents ~/.github/agents
ln -s /path/to/your/repo/instructions ~/.github/instructions
ln -s /path/to/your/repo/prompts ~/.github/prompts
```

**Pros**: Changes in repo automatically apply globally
**Cons**: Breaks if you move/delete the repo

### 4. Global Git Hooks Template

This makes git hooks available for **all** your repositories.

#### macOS/Linux

```bash
# Create global hooks directory
mkdir -p ~/.git-templates/hooks

# Create post-commit hook
cat > ~/.git-templates/hooks/post-commit << 'EOF'
#!/bin/bash
# Auto-update code-review-graph after commits
# Only runs if code-review-graph is initialized in the repo

if [ -d ".code-graph" ]; then
    echo "Updating code graph..."
    code-review-graph update --skip-flows
    
    if [ $? -eq 0 ]; then
        echo "✓ Code graph updated successfully"
    else
        echo "⚠ Code graph update failed (non-blocking)"
    fi
fi
EOF

# Create post-merge hook
cat > ~/.git-templates/hooks/post-merge << 'EOF'
#!/bin/bash
# Auto-update code-review-graph after merges
# Only runs if code-review-graph is initialized in the repo

if [ -d ".code-graph" ]; then
    echo "Updating code graph after merge..."
    code-review-graph update --skip-flows
    
    if [ $? -eq 0 ]; then
        echo "✓ Code graph updated successfully"
    else
        echo "⚠ Code graph update failed (non-blocking)"
    fi
fi
EOF

# Make hooks executable
chmod +x ~/.git-templates/hooks/post-commit
chmod +x ~/.git-templates/hooks/post-merge

# Configure git to use this template
git config --global init.templateDir ~/.git-templates

# Apply to existing repos
cd /path/to/your/repo
git init  # Re-initializes with new hooks (safe, doesn't lose data)
```

#### Windows (PowerShell)

```powershell
# Create global hooks directory
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.git-templates\hooks"

# Create post-commit hook
@"
#!/bin/bash
# Auto-update code-review-graph after commits
# Only runs if code-review-graph is initialized in the repo

if [ -d ".code-graph" ]; then
    echo "Updating code graph..."
    code-review-graph update --skip-flows
    
    if [ `$? -eq 0 ]; then
        echo "✓ Code graph updated successfully"
    else
        echo "⚠ Code graph update failed (non-blocking)"
    fi
fi
"@ | Out-File -FilePath "$env:USERPROFILE\.git-templates\hooks\post-commit" -Encoding UTF8

# Create post-merge hook
@"
#!/bin/bash
# Auto-update code-review-graph after merges
# Only runs if code-review-graph is initialized in the repo

if [ -d ".code-graph" ]; then
    echo "Updating code graph after merge..."
    code-review-graph update --skip-flows
    
    if [ `$? -eq 0 ]; then
        echo "✓ Code graph updated successfully"
    else
        echo "⚠ Code graph update failed (non-blocking)"
    fi
fi
"@ | Out-File -FilePath "$env:USERPROFILE\.git-templates\hooks\post-merge" -Encoding UTF8

# Configure git to use this template
git config --global init.templateDir "$env:USERPROFILE\.git-templates"
```

### 5. VSCode Tasks (Workspace-Specific Only)

**Important**: VSCode tasks are **always workspace-specific** and cannot be configured globally. However, you can:

#### Option A: Create a Template

```bash
# Create a template directory
mkdir -p ~/.vscode-templates

# Copy tasks.json template
cp .vscode/tasks.json ~/.vscode-templates/tasks.json
```

Then for each new project:

```bash
cd /path/to/new/project
mkdir -p .vscode
cp ~/.vscode-templates/tasks.json .vscode/tasks.json
```

#### Option B: Use VSCode Snippets

Create a snippet for quick task creation:

1. Open VSCode
2. Press `Cmd+Shift+P` → "Preferences: Configure User Snippets"
3. Select "json.json"
4. Add:

```json
{
  "Code Graph Tasks": {
    "prefix": "code-graph-tasks",
    "body": [
      "{",
      "    \"version\": \"2.0.0\",",
      "    \"tasks\": [",
      "        {",
      "            \"label\": \"Update Code Graph\",",
      "            \"type\": \"shell\",",
      "            \"command\": \"code-review-graph update --skip-flows\",",
      "            \"problemMatcher\": []",
      "        },",
      "        {",
      "            \"label\": \"Check Code Graph Status\",",
      "            \"type\": \"shell\",",
      "            \"command\": \"code-review-graph status\",",
      "            \"problemMatcher\": []",
      "        }",
      "    ]",
      "}"
    ],
    "description": "Code graph VSCode tasks"
  }
}
```

Then in any `tasks.json`, type `code-graph-tasks` and press Tab.

## Verification

### 1. Verify MCP Configuration

```bash
# macOS
cat ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json

# Linux
cat ~/.config/Code/User/globalStorage/github.copilot-chat/mcp.json

# Windows
type %APPDATA%\Code\User\globalStorage\github.copilot-chat\mcp.json
```

### 2. Verify VSCode Settings

Open VSCode:
- Press `Cmd+Shift+P` / `Ctrl+Shift+P`
- Type "Preferences: Open User Settings (JSON)"
- Check for `github.copilot.chat.codeGeneration.instructions`

### 3. Verify Global Agents/Instructions

```bash
ls -la ~/.github/agents/
ls -la ~/.github/instructions/
```

### 4. Verify Git Hooks Template

```bash
# Check template is configured
git config --global init.templateDir

# Check hooks exist
ls -la ~/.git-templates/hooks/

# Test in a repo
cd /path/to/repo
ls -la .git/hooks/post-commit
```

### 5. Test in VSCode

1. Open any project in VSCode
2. Open Copilot Chat
3. Type: `@workspace Use the code graph to show architecture overview`
4. Should use the MCP tools

## Updating Global Configuration

### Update MCP Config

```bash
# macOS/Linux
nano ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json

# Or use VSCode
code ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json
```

### Update Agents/Instructions

```bash
# If you copied files
cp agents/*.agent.md ~/.github/agents/
cp instructions/*.instructions.md ~/.github/instructions/

# If you symlinked, changes in repo automatically apply
```

### Update Git Hooks

```bash
# Edit hooks
nano ~/.git-templates/hooks/post-commit

# Apply to existing repos
cd /path/to/repo
git init  # Re-applies template
```

## Workspace vs User-Level: When to Use What

### Use Workspace-Level When:
- ✅ Configuration is project-specific
- ✅ You want to commit config to repo (team sharing)
- ✅ Different projects need different settings
- ✅ You want version control for configuration

### Use User-Level When:
- ✅ Configuration applies to all your projects
- ✅ You want consistent behavior across projects
- ✅ You don't want to duplicate config in every repo
- ✅ Personal preferences (not team-wide)

## Hybrid Approach (Recommended)

Use both levels for maximum flexibility:

```
User-Level (Global):
├── MCP config (code-review-graph available everywhere)
├── VSCode settings (general Copilot behavior)
├── Git hooks template (auto-update in all repos)
└── Core agents/instructions (reusable across projects)

Workspace-Level (Per-Project):
├── Project-specific agents (if any)
├── Project-specific instructions (if any)
├── VSCode tasks (project-specific commands)
└── Workspace settings (override user settings)
```

## Migration: Workspace → User-Level

If you have workspace-level config and want to move to user-level:

```bash
# 1. Copy MCP config
cp .vscode/mcp.json ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json

# 2. Copy agents/instructions
cp -r agents ~/.github/
cp -r instructions ~/.github/
cp -r prompts ~/.github/

# 3. Set up git hooks template
mkdir -p ~/.git-templates/hooks
cp .git-hooks/post-commit ~/.git-templates/hooks/
cp .git-hooks/post-merge ~/.git-templates/hooks/
chmod +x ~/.git-templates/hooks/*
git config --global init.templateDir ~/.git-templates

# 4. Update VSCode user settings
# (manually add instructions to User Settings JSON)

# 5. Optional: Remove workspace-level config
# rm -rf .vscode/mcp.json  # Keep if you want workspace override
# rm -rf .git-hooks/       # Keep if you want workspace-specific hooks
```

## Troubleshooting

### MCP Server Not Loading

```bash
# Check file exists
ls -la ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json

# Check JSON syntax
cat ~/Library/Application\ Support/Code/User/globalStorage/github.copilot-chat/mcp.json | python -m json.tool

# Restart VSCode completely
```

### Agents Not Found

```bash
# Check directory exists
ls -la ~/.github/agents/

# Check GitHub Copilot can access it
# (May need to configure in Copilot settings)
```

### Git Hooks Not Running

```bash
# Check template is configured
git config --global init.templateDir

# Check hooks are executable
ls -la ~/.git-templates/hooks/

# Make executable if needed
chmod +x ~/.git-templates/hooks/*

# Re-apply to repo
cd /path/to/repo
git init
```

### Workspace Config Overrides User Config

This is expected behavior. Workspace settings take precedence over user settings.

To use user-level config:
- Remove or rename `.vscode/mcp.json` in workspace
- Remove conflicting settings from `.vscode/settings.json`

## Best Practices

1. **Use user-level for common config** — MCP, core agents, git hooks
2. **Use workspace-level for project-specific** — Custom agents, tasks, overrides
3. **Document in README** — Tell team members about global setup
4. **Version control workspace config** — Commit `.vscode/` for team sharing
5. **Keep user config private** — Don't commit `~/.github/` to repos
6. **Test after setup** — Verify in a new project
7. **Update regularly** — Keep global agents/instructions in sync

## Summary

User-level configuration locations:

| File | Location (macOS) |
|------|------------------|
| MCP Config | `~/Library/Application Support/Code/User/globalStorage/github.copilot-chat/mcp.json` |
| VSCode Settings | `~/Library/Application Support/Code/User/settings.json` |
| Agents | `~/.github/agents/` |
| Instructions | `~/.github/instructions/` |
| Prompts | `~/.github/prompts/` |
| Git Hooks | `~/.git-templates/hooks/` |

**Tasks are workspace-only** — Use templates or snippets for reuse.

After setup, the code-review-graph integration will work in **all** your VSCode projects automatically!
