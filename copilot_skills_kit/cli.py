"""CLI entry point for the copilot-skills-kit pip package."""

from __future__ import annotations

import argparse
import os
import platform
import shutil
import sys
from pathlib import Path

VERSION = "2.0.0"


# ─── Data location ────────────────────────────────────────────────────────────

def _get_data_root() -> Path:
    """Return the path to the framework's data files.

    Resolution order:
    1. ``copilot_skills_kit/data/`` — present in a built pip wheel after
       running ``python scripts/sync_data.py`` before publishing.
    2. Repository root — used when the package is installed in editable mode
       (``pip install -e .``) directly from the cloned source.

    Raises RuntimeError if neither location can be found.
    """
    pkg_data = Path(__file__).parent / "data"
    if pkg_data.is_dir() and any(pkg_data.iterdir()):
        return pkg_data

    # Editable install: __file__ is the real source file inside the repo
    source_root = Path(__file__).parent.parent
    if (source_root / "agents").is_dir():
        return source_root

    raise RuntimeError(
        "Cannot locate framework data files.\n"
        "  • If you installed from PyPI: the package may be incomplete. "
        "Try reinstalling: pip install --force-reinstall copilot-skills-kit\n"
        "  • If you are developing locally: use 'pip install -e .' (editable mode) "
        "or run 'python scripts/sync_data.py' before 'pip install .'"
    )


# ─── Platform helpers ─────────────────────────────────────────────────────────

def _vscode_user_prompts_dir() -> Path:
    system = platform.system()
    home = Path.home()

    if system == "Darwin":
        return home / "Library" / "Application Support" / "Code" / "User" / "prompts"
    if system == "Windows":
        appdata = os.environ.get("APPDATA")
        if not appdata:
            raise RuntimeError(
                "APPDATA environment variable is not set. Cannot locate VS Code on Windows."
            )
        return Path(appdata) / "Code" / "User" / "prompts"
    # Linux and other Unix
    return home / ".config" / "Code" / "User" / "prompts"


# ─── File-copy helpers ────────────────────────────────────────────────────────

def _copy_files_flat(src_dir: Path, dest_dir: Path) -> int:
    """Copy all files from src_dir into dest_dir (non-recursive). Returns file count."""
    if not src_dir.is_dir():
        return 0
    dest_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    for entry in src_dir.iterdir():
        if entry.is_file():
            shutil.copy2(entry, dest_dir / entry.name)
            count += 1
    return count


def _copy_dir(src: Path, dest: Path) -> None:
    """Recursively copy src into dest, replacing dest if it already exists."""
    if not src.is_dir():
        return
    if dest.exists():
        shutil.rmtree(dest)
    shutil.copytree(src, dest)


# ─── Install steps ────────────────────────────────────────────────────────────

def _install_global(data_root: Path) -> None:
    prompts_dir = _vscode_user_prompts_dir()
    prompts_dir.mkdir(parents=True, exist_ok=True)

    total = sum(
        _copy_files_flat(data_root / d, prompts_dir)
        for d in ("agents", "prompts", "instructions")
    )
    print(f"  ✓  Installed {total} files → {prompts_dir}")

    skill_src = data_root / "skills" / "graphify.skill.md"
    if skill_src.exists():
        skill_dest = Path.home() / ".copilot" / "skills" / "graphify" / "SKILL.md"
        skill_dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(skill_src, skill_dest)
        print(f"  ✓  Installed graphify skill → {skill_dest}")


def _install_to_repo(data_root: Path, target: Path) -> None:
    for dir_name in ("agents", "instructions", "prompts", "skills"):
        src = data_root / dir_name
        if not src.is_dir():
            continue
        _copy_dir(src, target / ".github" / dir_name)
        print(f"  ✓  Copied {dir_name}/ → .github/{dir_name}/")

    # Ensure .copilot/context/ exists so agents have a place to write artifacts
    (target / ".copilot" / "context").mkdir(parents=True, exist_ok=True)

    # Write .vscode/settings.json only when one does not already exist
    settings_src = data_root / "vscode" / "settings.json"
    settings_dest = target / ".vscode" / "settings.json"
    if settings_src.exists() and not settings_dest.exists():
        settings_dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(settings_src, settings_dest)
        print("  ✓  Created .vscode/settings.json")

    print(f"  ✓  Framework installed to {target}")


# ─── CLI ──────────────────────────────────────────────────────────────────────

def main() -> None:
    parser = argparse.ArgumentParser(
        prog="copilot-skills-kit",
        description=(
            "Install the GitHub Copilot skills framework into VS Code "
            "and/or a target repository."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "Examples:\n"
            "  copilot-skills-kit install\n"
            "  copilot-skills-kit install --target ~/projects/my-app\n"
            "  copilot-skills-kit install --global-only\n"
        ),
    )
    parser.add_argument("--version", action="version", version=VERSION)

    subparsers = parser.add_subparsers(dest="command")
    install_cmd = subparsers.add_parser(
        "install",
        help="Copy agents, prompts, instructions, and skills into VS Code and the target repo.",
    )
    install_cmd.add_argument(
        "--target",
        default=None,
        metavar="PATH",
        help="Repository root to install into (.github/). Defaults to the current directory.",
    )
    install_cmd.add_argument(
        "--global-only",
        action="store_true",
        help="Only install to VS Code's global user prompts; skip per-repo .github/ install.",
    )

    args = parser.parse_args()

    if args.command is None:
        parser.print_help()
        sys.exit(0)

    target = Path(args.target).resolve() if args.target else Path.cwd()

    print("\ncopilot-skills-kit — Installing GitHub Copilot skills framework\n")

    try:
        data_root = _get_data_root()
        _install_global(data_root)
        if not args.global_only:
            _install_to_repo(data_root, target)
    except Exception as exc:
        print(f"\n  ✗  Error: {exc}", file=sys.stderr)
        sys.exit(1)

    print("\n✅  Done! Open VS Code and start using @Product, @Architect, /spec, and more.\n")
    print("Next steps:")
    print("  1. Open your repo in VS Code.")
    print("  2. Update .copilot/context/overview.md with your project details.")
    print("  3. Type '@Product Please create a spec for [feature]' in Copilot Chat.\n")


if __name__ == "__main__":
    main()
