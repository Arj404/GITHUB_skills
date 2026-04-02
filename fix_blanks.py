"""
fix_blanks.py — Normalize blank lines in any file.

Rules applied to the entire file (or from a start line):
  - Single blank line between text  → removed
  - 2+ consecutive blank lines      → replaced with exactly one blank line

Usage:
  python3 fix_blanks.py <filename>
  python3 fix_blanks.py <filename> --from <line_number>

Examples:
  python3 fix_blanks.py README.md
  python3 fix_blanks.py README.md --from 493
"""

import sys
import os


def fix_blanks(filepath, start_line=1):
    if not os.path.isfile(filepath):
        print(f"Error: file '{filepath}' not found.")
        sys.exit(1)

    with open(filepath, 'r') as f:
        lines = f.readlines()

    original_count = len(lines)
    # Lines before start_line are kept unchanged (1-indexed → 0-indexed: start_line - 1)
    fixed_lines = lines[:start_line - 1]

    i = start_line - 1
    while i < len(lines):
        if lines[i].strip() == '':
            # Count consecutive blank lines
            count = 0
            while i + count < len(lines) and lines[i + count].strip() == '':
                count += 1
            if count >= 2:
                fixed_lines.append('\n')  # multiple blank lines → keep exactly one
            # single blank line (count == 1) → removed
            i += count
        else:
            fixed_lines.append(lines[i])
            i += 1

    with open(filepath, 'w') as f:
        f.writelines(fixed_lines)

    print(f"Done! '{filepath}': {original_count} → {len(fixed_lines)} lines")


if __name__ == '__main__':
    args = sys.argv[1:]

    if not args or args[0] in ('-h', '--help'):
        print(__doc__)
        sys.exit(0)

    filepath = args[0]
    start_line = 1

    if '--from' in args:
        idx = args.index('--from')
        try:
            start_line = int(args[idx + 1])
        except (IndexError, ValueError):
            print("Error: --from requires a line number, e.g. --from 493")
            sys.exit(1)

    fix_blanks(filepath, start_line)
