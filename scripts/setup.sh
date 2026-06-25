#!/usr/bin/env bash
# =============================================================================
# setup.sh - GITHUB_skills framework onboarding script
#
# Usage:
#   bash scripts/setup.sh [TARGET_REPO_PATH]
#
#   TARGET_REPO_PATH: (optional) Path to the repo you want to set up.
#                     Defaults to the current directory.
#
# What this script does:
#   1. Detects the OS (macOS / Linux / Windows via Git Bash / WSL)
#   2. Installs agents, prompts, and instructions to the VS Code global user
#      prompts directory so they work across ALL repos without per-repo setup:
#        macOS/Linux  → ~/Library/Application Support/Code/User/prompts/  (macOS)
#                       ~/.config/Code/User/prompts/                       (Linux)
#        Windows      → $APPDATA/Code/User/prompts/                        (Git Bash)
#   3. Copies framework files into .github/ of the TARGET repo for per-repo use
#   4. Creates default .copilot/context/ configuration files if missing
#   5. Configures git hooks
#   6. Writes a recommended .vscode/settings.json
# =============================================================================

set -euo pipefail

# ─── Colours ────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'
BOLD='\033[1m'; RESET='\033[0m'

info()    { echo -e "${BLUE}ℹ${RESET}  $*"; }
success() { echo -e "${GREEN}✓${RESET}  $*"; }
warn()    { echo -e "${YELLOW}⚠${RESET}  $*"; }
error()   { echo -e "${RED}✗${RESET}  $*" >&2; }
header()  { echo -e "\n${BOLD}${BLUE}──────────────────────────────────────${RESET}"; echo -e "${BOLD} $*${RESET}"; echo -e "${BOLD}${BLUE}──────────────────────────────────────${RESET}"; }

# ─── Detect script location (GITHUB_skills repo root) ───────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ─── Target repo (default: current directory) ────────────────────────────────
TARGET="${1:-$(pwd)}"
TARGET="$(cd "$TARGET" && pwd)"

header "🚀 GITHUB_skills Framework Setup"
info "Framework root : $FRAMEWORK_ROOT"
info "Target repo    : $TARGET"

# ─── 1. Platform Detection ───────────────────────────────────────────────────
header "1. Detecting Platform"
OS="unknown"
case "$(uname -s 2>/dev/null || echo 'Windows')" in
  Darwin)  OS="macos"   ; success "macOS detected" ;;
  Linux)   OS="linux"   ; success "Linux detected" ;;
  MINGW*|MSYS*|CYGWIN*) OS="windows" ; success "Windows (Git Bash / MSYS) detected" ;;
  *)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      OS="wsl"; success "WSL detected"
    else
      warn "Unknown platform — proceeding with generic Unix steps"
      OS="unix"
    fi
    ;;
esac

# ─── 2. Check Python & pip ───────────────────────────────────────────────────
header "2. Checking Python"
if command -v python3 &>/dev/null; then
  PYTHON=python3
elif command -v python &>/dev/null && python --version 2>&1 | grep -q "3\."; then
  PYTHON=python
else
  error "Python 3 is required but not found. Please install it from https://python.org"
  exit 1
fi
success "Python found: $($PYTHON --version)"

# ─── 3. Resolve VS Code global user prompts directory ────────────────────────
header "3. Installing to VS Code global user prompts directory"
case "$OS" in
  macos)
    VSCODE_USER_PROMPTS="$HOME/Library/Application Support/Code/User/prompts"
    ;;
  linux|unix)
    VSCODE_USER_PROMPTS="$HOME/.config/Code/User/prompts"
    ;;
  windows)
    # Git Bash exposes $APPDATA as a Windows path; convert it
    if [ -n "${APPDATA:-}" ]; then
      # Convert Windows path to Git Bash Unix path (e.g. C:\Users\... → /c/Users/...)
      VSCODE_USER_PROMPTS="$(echo "$APPDATA" | sed 's|\\|/|g' | sed 's|^\([A-Za-z]\):|/\L\1|')/Code/User/prompts"
    else
      warn "APPDATA not set — cannot resolve VS Code user prompts path on Windows"
      VSCODE_USER_PROMPTS=""
    fi
    ;;
  wsl)
    # Access the Windows APPDATA path via /mnt/c/...
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r' || echo "")
    if [ -n "$WIN_USER" ]; then
      VSCODE_USER_PROMPTS="/mnt/c/Users/$WIN_USER/AppData/Roaming/Code/User/prompts"
    else
      warn "Could not detect Windows username in WSL — falling back to Linux path"
      VSCODE_USER_PROMPTS="$HOME/.config/Code/User/prompts"
    fi
    ;;
  *)
    warn "Unknown OS — skipping global VS Code install"
    VSCODE_USER_PROMPTS=""
    ;;
esac

if [ -n "$VSCODE_USER_PROMPTS" ]; then
  info "VS Code global prompts dir: $VSCODE_USER_PROMPTS"
  mkdir -p "$VSCODE_USER_PROMPTS"

  # Copy all agents, prompts, and instructions flat into the global dir
  COPIED=0
  for dir in agents prompts instructions; do
    if [ -d "$FRAMEWORK_ROOT/$dir" ]; then
      for f in "$FRAMEWORK_ROOT/$dir"/*.md; do
        [ -f "$f" ] || continue
        dest="$VSCODE_USER_PROMPTS/$(basename "$f")"
        cp "$f" "$dest"
        COPIED=$((COPIED + 1))
      done
    fi
  done
  success "Installed $COPIED files to global VS Code prompts dir"
else
  warn "Skipping global VS Code install (path not resolved)"
fi

# ─── 4. Copy Framework Files to Target Repo (.github/) ───────────────────────
header "4. Copying Framework Files to Target Repo"
if [ "$TARGET" != "$FRAMEWORK_ROOT" ]; then
  # Copy agents/, instructions/, prompts/, skills/ into .github/ in the target repo
  for dir in agents instructions prompts skills; do
    SRC_DIR="$FRAMEWORK_ROOT/$dir"
    DST_DIR="$TARGET/.github/$dir"
    if [ -d "$SRC_DIR" ]; then
      mkdir -p "$DST_DIR"
      cp -r "$SRC_DIR"/. "$DST_DIR/"
      success "Copied $dir/ → .github/$dir/"
    else
      warn "$dir/ not found in framework root — skipping"
    fi
  done

  # Copy .copilot/context/ defaults only
  mkdir -p "$TARGET/.copilot/context"
  for f in overview.md constraints.md; do
    SRC="$FRAMEWORK_ROOT/copilot/context/$f"
    DST="$TARGET/.copilot/context/$f"
    if [ -f "$SRC" ] && [ ! -f "$DST" ]; then
      cp "$SRC" "$DST"
      success "Copied .copilot/context/$f"
    elif [ -f "$DST" ]; then
      warn ".copilot/context/$f already exists — skipping"
    fi
  done
else
  info "Target is the framework root itself — skipping file copy"
fi

# ─── 5. Create paths.md ──────────────────────────────────────────────────────
header "5. Initialising Path Configuration"
PATHS_FILE="$TARGET/.copilot/context/paths.md"
mkdir -p "$TARGET/.copilot/context"
if [ ! -f "$PATHS_FILE" ]; then
  cat > "$PATHS_FILE" << 'PATHS_EOF'
# Project Paths
Define your repository structure here. Agents will use these paths instead of hardcoded defaults to navigate your codebase.

| Path | Purpose |
|------|---------|
| `src/` | Source code root (where application code lives) |
| `tests/` | Test code root |
| `docs/` | Project documentation, architecture diagrams, and ADRs |
| `scripts/` | Utility scripts, automation, and dev tools |
| `git-hooks/` | Git hooks |
| `.github/` | CI/CD and AI orchestration config |
| `.copilot/` | Copilot AI artifacts, specs, and context |

> [!TIP]
> Update the paths above if your repository has a different structure (e.g., `impl/src/` or `packages/backend/src/`). Agents will dynamically adjust their scope based on this file.
PATHS_EOF
  success "Created .copilot/context/paths.md"
else
  success "paths.md already exists — skipping"
fi

# ─── 6. Git Hooks ────────────────────────────────────────────────────────────
header "6. Configuring Git Hooks"
HOOKS_DIR="$TARGET/git-hooks"
if [ ! -d "$HOOKS_DIR" ] && [ -d "$FRAMEWORK_ROOT/git-hooks" ]; then
  cp -r "$FRAMEWORK_ROOT/git-hooks" "$TARGET/"
  success "Copied git-hooks/"
fi

if [ -d "$HOOKS_DIR" ]; then
  # Determine git dir
  GIT_DIR=$(git -C "$TARGET" rev-parse --git-dir 2>/dev/null || echo "")
  if [ -n "$GIT_DIR" ]; then
    git -C "$TARGET" config core.hooksPath git-hooks
    chmod +x "$HOOKS_DIR"/* 2>/dev/null || true
    success "Git hooks configured (core.hooksPath=git-hooks)"
  else
    warn "Target is not a git repository — skipping hook configuration"
  fi
else
  warn "git-hooks/ directory not found — skipping"
fi

# ─── 7. VS Code Settings ─────────────────────────────────────────────────────
header "7. Writing VS Code Settings"
VSCODE_DIR="$TARGET/.vscode"
SETTINGS_FILE="$VSCODE_DIR/settings.json"
mkdir -p "$VSCODE_DIR"
if [ ! -f "$SETTINGS_FILE" ]; then
  cat > "$SETTINGS_FILE" << 'VSCODE_EOF'
{
  "chat.promptFilesLocations": [".github/prompts", ".github/agents"],
  "github.copilot.chat.codeGeneration.instructions": [
    { "file": ".github/instructions/copilot.instructions.md" }
  ],
  "github.copilot.chat.experimental.codeGeneration.instructions": [
    { "file": ".github/instructions/copilot.instructions.md" }
  ],
  "github.copilot.chat.useProjectTemplates": true,
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode"
}
VSCODE_EOF
  success "Created .vscode/settings.json"
else
  warn ".vscode/settings.json already exists — skipping to preserve your settings"
  info "Ensure these keys are present:"
  echo '    "chat.promptFilesLocations": [".github/prompts", ".github/agents"]'
  echo '    "github.copilot.chat.codeGeneration.instructions": [{"file": ".github/instructions/copilot.instructions.md"}]'
fi

# ─── Done ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}✅ Setup complete!${RESET} The GITHUB_skills framework is ready."
echo ""
echo -e "${BOLD}Next steps:${RESET}"
echo "  1. Open $TARGET in VS Code."
echo "  2. Update .copilot/context/overview.md with your project details."
echo "  3. Update .copilot/context/paths.md if your folder structure differs."
echo "  4. Type '@Product Please create a spec for [feature]' in Copilot Chat to start."
echo ""
