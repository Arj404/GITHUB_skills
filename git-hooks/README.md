# Git Hooks for Code Graph Auto-Update

This directory contains git hooks that automatically update the code-review-graph after code changes.

## Available Hooks

### post-commit
Updates the graph after each commit.

### post-merge
Updates the graph after pulling or merging changes.

## Installation

Git hooks need to be installed in the `.git/hooks/` directory. You have two options:

### Option 1: Manual Installation (Copy)

```bash
# Copy hooks to .git/hooks/
cp .git-hooks/post-commit .git/hooks/post-commit
cp .git-hooks/post-merge .git/hooks/post-merge

# Make them executable
chmod +x .git/hooks/post-commit
chmod +x .git/hooks/post-merge
```

### Option 2: Symlink Installation (Recommended)

```bash
# Create symlinks (changes here automatically apply)
ln -sf ../../.git-hooks/post-commit .git/hooks/post-commit
ln -sf ../../.git-hooks/post-merge .git/hooks/post-merge

# Make source files executable
chmod +x .git-hooks/post-commit
chmod +x .git-hooks/post-merge
```

### Option 3: Git Config (Git 2.9+)

```bash
# Configure git to use this directory for hooks
git config core.hooksPath .git-hooks

# Make hooks executable
chmod +x .git-hooks/post-commit
chmod +x .git-hooks/post-merge
```

## Verify Installation

```bash
# Check if hooks are installed
ls -la .git/hooks/post-commit
ls -la .git/hooks/post-merge

# Test a hook manually
.git/hooks/post-commit
```

## Disable Hooks Temporarily

```bash
# Skip hooks for a single commit
git commit --no-verify

# Disable all hooks temporarily
git config core.hooksPath /dev/null

# Re-enable
git config core.hooksPath .git-hooks
```

## Uninstall Hooks

```bash
# Remove hooks
rm .git/hooks/post-commit
rm .git/hooks/post-merge

# Or reset to default hooks path
git config --unset core.hooksPath
```

## How It Works

1. You make changes and commit: `git commit -m "Add feature"`
2. Git runs `.git/hooks/post-commit` (or `.git-hooks/post-commit` if using core.hooksPath)
3. Hook runs: `code-review-graph update --skip-flows`
4. Graph is updated with your changes
5. Next time an agent queries the graph, it has current information

## Troubleshooting

### Hook Not Running

```bash
# Check if hook is executable
ls -la .git/hooks/post-commit

# Make it executable
chmod +x .git/hooks/post-commit

# Check git config
git config core.hooksPath
```

### Hook Fails

```bash
# Test hook manually
.git/hooks/post-commit

# Check if code-review-graph is installed
which code-review-graph
uvx code-review-graph --help

# Check graph status
code-review-graph status
```

### Hook Slows Down Commits

The hooks use `--skip-flows` flag to make updates faster. If still too slow:

```bash
# Edit the hook to run in background
# Change: code-review-graph update --skip-flows
# To: code-review-graph update --skip-flows &
```

Or disable hooks and update manually:

```bash
# After a work session
code-review-graph update
```

## Best Practices

1. **Use symlinks** (Option 2) — Changes to hooks automatically apply
2. **Use core.hooksPath** (Option 3) — Cleanest approach for team sharing
3. **Commit hooks to repo** — Team members can easily install them
4. **Test hooks** — Run manually before relying on them
5. **Keep hooks fast** — Use `--skip-flows` flag for quick updates

## Team Setup

To help team members install hooks, add to your README:

```markdown
## Setup

After cloning, install git hooks:

\`\`\`bash
git config core.hooksPath .git-hooks
chmod +x .git-hooks/*
\`\`\`
```

## Alternative: Pre-commit Framework

If your team uses [pre-commit](https://pre-commit.com/), add to `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: local
    hooks:
      - id: update-code-graph
        name: Update Code Graph
        entry: code-review-graph update --skip-flows
        language: system
        stages: [post-commit, post-merge]
        pass_filenames: false
```

Then install:

```bash
pre-commit install --hook-type post-commit
pre-commit install --hook-type post-merge
```
