# Skills Directory

This directory contains skill definitions for GitHub Copilot and other AI assistants.

## What are Skills?

Skills are specialized capabilities that can be triggered by commands (like `/graphify`) or automatically loaded as instructions. They define:

- **Trigger**: Command to invoke the skill (e.g., `/graphify`)
- **Description**: What the skill does
- **Instructions**: Step-by-step procedures for the AI to follow
- **Usage**: How to use the skill effectively

## Available Skills

### graphify.skill.md

**Trigger**: `/graphify`

**Description**: Turn any folder of files into a navigable knowledge graph with community detection, an honest audit trail, and three outputs: interactive HTML, GraphRAG-ready JSON, and a plain-language GRAPH_REPORT.md.

**Usage**:
```
/graphify                     # Full pipeline on current directory
/graphify <path>              # Full pipeline on specific path
/graphify <path> --update     # Incremental - re-extract only new/changed files
/graphify <path> --no-viz     # Skip visualization, just report + JSON
/graphify <path> --wiki       # Build agent-crawlable wiki
/graphify query "<question>"  # BFS traversal - broad context
```

## How Skills Work

Skills are loaded by GitHub Copilot through the `vscode/settings.json` configuration:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "file": "skills/graphify.skill.md"
    }
  ]
}
```

When you type `/graphify` in Copilot Chat, it:
1. Recognizes the trigger from the skill definition
2. Loads the instructions from the skill file
3. Executes the step-by-step procedures
4. Returns the results

## Creating New Skills

To create a new skill:

1. **Create a new file**: `skills/your-skill.skill.md`

2. **Add frontmatter**:
```markdown
---
name: your-skill
description: What your skill does
trigger: /your-skill
---
```

3. **Write instructions**: Provide clear, step-by-step instructions for the AI

4. **Add to settings**: Update `vscode/settings.json` to include your skill

5. **Test**: Try the trigger command in Copilot Chat

## Best Practices

1. **Clear triggers**: Use descriptive, memorable command names
2. **Detailed instructions**: Provide step-by-step procedures
3. **Error handling**: Include troubleshooting steps
4. **Examples**: Show usage examples
5. **Documentation**: Explain what the skill does and why

## Related Directories

- **[instructions/](../instructions/)** - General instruction files for coding standards
- **[prompts/](../prompts/)** - Prompt templates for specific tasks
- **[agents/](../agents/)** - Agent definitions for specialized workflows

## Resources

- **[GitHub Copilot Skills Documentation](https://docs.github.com/en/copilot)** - Official documentation
- **[GRAPHIFY_SETUP.md](../GRAPHIFY_SETUP.md)** - Setup guide for graphify skill
- **[README.md](../README.md)** - Main project documentation
