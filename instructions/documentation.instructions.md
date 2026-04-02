---
applyTo: "**/*.{md,mdx,rst,txt,adoc}"
---

# Documentation Standards

## README Structure

Every project MUST include a README with at minimum:

- **Project title and one-line description** — what it does and why.
- **Prerequisites** — runtime versions, tools, accounts, environment variables.
- **Quick start** — steps to clone, install, configure, and run locally (copy-pasteable commands).
- **Architecture overview** — high-level diagram or description of major components.
- **Directory structure** — annotated tree showing where key files live.
- **Testing** — how to run unit, integration, and other test suites.
- **Deployment** — how to build, containerize, and deploy.
- **Contributing** — link to contributing guidelines and code of conduct.

## API Documentation

- Document all public APIs with OpenAPI/Swagger specifications.
- Include request/response examples for every endpoint.
- Document error codes, rate limits, and authentication requirements.
- Keep API docs versioned alongside the code; auto-generate where possible.

## Architecture Decision Records (ADRs)

- Record significant architecture and technology decisions in `impl/doc/adr/` or `docs/adr/`.
- Use a consistent template: Title, Status, Context, Decision, Consequences.
- ADRs are immutable once accepted; supersede with a new ADR when decisions change.

## Inline Documentation

- Docstrings are required for all public modules, classes, and functions.
- Comments explain "why", not "what" — the code itself should explain "what".
- Keep documentation co-located with the code it describes; avoid external wikis for API-level details.
- Update documentation in the same commit/PR as the code change.

## Diagrams

- Use text-based diagramming (Mermaid, PlantUML) so diagrams are version-controlled alongside code.
- Include at minimum: system context diagram, container diagram, and data flow diagram.
- Store diagram source in `impl/doc/diagrams/` or alongside the feature documentation.

## Changelog

- Maintain a `CHANGELOG.md` following Keep a Changelog format.
- Group entries under: Added, Changed, Deprecated, Removed, Fixed, Security.
- Link each release entry to the corresponding git tag.

## References

- Follow [copilot](copilot.instructions.md) for Copilot behavior rules.
- Follow [architecture](architecture.instructions.md) for architecture documentation.
