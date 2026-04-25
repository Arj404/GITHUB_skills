#!/usr/bin/env python3
"""Sync framework data files into copilot_skills_kit/data/ for pip distribution.

Run this script before building and publishing the pip package:

    python scripts/sync_data.py
    python -m build
    twine upload dist/*

The copilot_skills_kit/data/ directory is listed in .gitignore because it
mirrors files that already live at the repository root (agents/, prompts/,
instructions/, skills/, vscode/). This script generates it fresh so the
built wheel contains the correct, up-to-date copies.
"""

import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
DATA_DIR = REPO_ROOT / "copilot_skills_kit" / "data"

SOURCE_DIRS = ["agents", "prompts", "instructions", "skills", "vscode"]


def sync() -> None:
    print(f"Syncing data files to {DATA_DIR} ...")
    DATA_DIR.mkdir(parents=True, exist_ok=True)

    # Required so importlib.resources can traverse the package
    (DATA_DIR / "__init__.py").touch()

    for dir_name in SOURCE_DIRS:
        src = REPO_ROOT / dir_name
        dest = DATA_DIR / dir_name

        if not src.is_dir():
            print(f"  SKIP  {dir_name}/ (directory not found at repo root)")
            continue

        if dest.exists():
            shutil.rmtree(dest)
        shutil.copytree(src, dest)

        file_count = sum(1 for p in dest.rglob("*") if p.is_file())
        print(f"  ✓  {dir_name}/ → {file_count} file(s)")

    print("\nSync complete.")
    print("You can now build the package:")
    print("  python -m build")
    print("  twine upload dist/*")


if __name__ == "__main__":
    sync()
