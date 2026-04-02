---
applyTo: "**/*.{yaml,yml,tf,sh,cmd,ps1,Dockerfile}"
---

# DevOps and CI/CD Standards

## CI/CD Pipeline

- Define pipelines as code (e.g., GitHub Actions, GitLab CI, Cloud Build) versioned alongside the application.
- Pipeline stages MUST include: lint → build → test (unit + integration) → security scan → deploy.
- All quality gates (lint, test, security) MUST pass before deployment; never skip gates for production pipelines.
- Use branch-based deployment: `main` → production, `develop` → staging, feature branches → ephemeral previews.

## Containerization

- Provide a `Dockerfile` for every deployable service; use multi-stage builds to minimize image size.
- Use a `.dockerignore` file to exclude build artifacts, secrets, and unnecessary files.
- Pin base image versions (e.g., `python:3.12-slim`, not `python:latest`).
- Run containers as a non-root user; avoid privileged mode.
- Include a `/health` endpoint for liveness and readiness probes.

## Environment Management

- Use Infrastructure as Code (Terraform, Bicep, Pulumi) for all infrastructure provisioning.
- Maintain environment parity: dev, staging, and production MUST use identical base configurations.
- Store environment-specific values in separate configuration files or secret managers; never in source code.
- Provide simple setup scripts (`scripts/setup.sh`, `scripts/dev.cmd`) for local development bootstrapping.

## Deployment

- Use blue/green or canary deployment strategies for zero-downtime releases.
- Document rollback procedures for every deployment target.
- Tag Docker images and releases with semantic versions linked to git tags.
- Automate database migration execution as part of the deployment pipeline.

## Monitoring and Observability

- Implement structured logging (JSON format) with correlation IDs for request tracing.
- Expose application metrics (request counts, latencies, error rates) for monitoring dashboards.
- Configure alerts for critical failures, error rate spikes, and resource exhaustion.
- Include instrumentation for distributed tracing in multi-service architectures.

## References

- Follow [security](security.instructions.md) for security in pipelines and infrastructure.
- Follow [coding.terraform](coding.terraform.instructions.md) for IaC standards.
