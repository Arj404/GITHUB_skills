# Read the file
with open('README.md', 'r') as f:
    lines = f.readlines()

# Keep lines 1-492 as-is, fix from 493 onwards
fixed_lines = lines[:492]

# Process rest to consolidate blank lines
i = 492
while i < len(lines):
    if lines[i].strip() == '':
        # Count consecutive blank lines
        blank_count = 1
        while i + blank_count < len(lines) and lines[i + blank_count].strip() == '':
            blank_count += 1
        # Add only one blank line
        fixed_lines.append('\n')
        i += blank_count
    else:
        fixed_lines.append(lines[i])
        i += 1

# Write back
with open('README.md', 'w') as f:
    f.writelines(fixed_lines)

print("Done!")
