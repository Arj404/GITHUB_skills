# Git Hooks

This directory is reserved for project git hooks. Currently no hooks are shipped with the framework.

## Installation

```bash
# Configure git to use this directory for hooks
git config core.hooksPath git-hooks

# Make hooks executable
chmod +x git-hooks/*
```

## Disable Hooks Temporarily

```bash
# Skip hooks for a single commit
git commit --no-verify

# Disable all hooks temporarily
git config core.hooksPath /dev/null

# Re-enable
git config core.hooksPath git-hooks
```
