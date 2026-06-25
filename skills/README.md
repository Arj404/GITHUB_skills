# Skills Directory

This directory contains skill definitions for GitHub Copilot and other AI assistants.

## What are Skills?

Skills are specialized capabilities that can be triggered by commands or automatically loaded as instructions. They define:

- **Trigger**: Command to invoke the skill
- **Description**: What the skill does
- **Instructions**: Step-by-step procedures for the AI to follow
- **Usage**: How to use the skill effectively

## Available Skills

No skills are currently shipped with the framework.

## How Skills Work

Skills are loaded by GitHub Copilot through the `vscode/settings.json` configuration:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    {
      "file": "skills/your-skill.skill.md"
    }
  ]
}
```

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
- **[README.md](../README.md)** - Main project documentation
