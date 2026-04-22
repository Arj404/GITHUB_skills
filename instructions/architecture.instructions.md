---
applyTo: "**/*.{py,go,ts,js,jsx,tsx,sql,tf,yaml,yml,json,md}"
---

# Architecture Principles

## Core Principles

- Apply separation of concerns: isolate data access, business logic, API/transport, and presentation layers.
- Each module MUST have a single responsibility with minimal coupling to other modules.
- Depend on abstractions, not concretions; use interfaces or abstract base classes at module boundaries.
- Prefer composition over inheritance for extending functionality.
- Design for containerization: applications MUST be runnable in Docker with minimal setup.

## API Design

- Use RESTful conventions for HTTP APIs: meaningful resource URIs, proper HTTP methods, and standard status codes.
- Version APIs explicitly (e.g., `/api/v1/`) from the start.
- Define request and response schemas using validation models (e.g., Pydantic, Zod, JSON Schema).
- Document all API endpoints with OpenAPI/Swagger specifications.

## Data Layer

- Use a single, well-defined ORM or query builder per project; avoid raw SQL unless performance-critical.
- Manage database schema changes through versioned migrations.
- Separate read and write models when complexity warrants it (CQRS pattern).
- Use PostgreSQL as the default RDBMS unless project requirements dictate otherwise.

## Module Structure

- Organize code into a clear directory structure: `src/config/`, `src/core/`, `src/modules/`, `src/shared/`.
- Place shared utilities, types, and constants in `src/shared/`.
- Place domain-specific logic in `src/modules/<domain>/`.
- Place application-wide configuration in `src/config/`.

## Documentation

- Provide clear setup and running instructions in the project README.
- Document architecture with diagrams (C4 model or equivalent) for system context, containers, and components.
- State all assumptions and limitations explicitly.

## References

- Follow [copilot](copilot.instructions.md) for Copilot behavior rules.
- Follow [security](security.instructions.md) for security baseline.
