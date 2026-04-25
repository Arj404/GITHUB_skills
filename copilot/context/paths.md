# Project Paths
Define your repository structure here. Agents will use these paths instead of hardcoded defaults to navigate your codebase.

| Path | Purpose |
|------|---------|
| `impl/src/` | Source code root (where application code lives) |
| `impl/test/` | Test code root |
| `impl/doc/` | Project documentation, architecture diagrams, and ADRs |
| `impl/script/` | Utility scripts, automation, and dev tools |
| `git-hooks/` | Git hooks |
| `.github/` | CI/CD and AI orchestration config |
| `.copilot/` | Copilot AI artifacts, specs, and context |

> [!TIP]
> Update the paths above if your repository has a different structure (e.g., changing `impl/src/` to `src/` or `packages/backend/src/`). Agents will dynamically adjust their scope based on this file.
