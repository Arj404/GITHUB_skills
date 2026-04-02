---
applyTo: "**"
---

# Security Standards

## Authentication and Authorization

- Use industry-standard protocols: OAuth 2.0 / OpenID Connect for web apps, API keys with rotation for service-to-service.
- Use JWT for stateless session management with short-lived tokens (≤1 hour) and refresh token rotation.
- Apply the principle of least privilege to every role, service account, and API scope.
- Enforce multi-factor authentication (MFA) for privileged access where supported.

## Secrets Management

- Never hardcode secrets, tokens, API keys, or credentials in source code — not even in demos or POCs.
- Store secrets in a secret manager (e.g., Vault, GCP Secret Manager, Azure Key Vault, AWS Secrets Manager).
- Use environment variables or secret-injection mechanisms at runtime; never commit `.env` files with real values.
- Rotate secrets regularly; automate rotation where the provider supports it.

## Input and Output

- Validate and sanitize all user input at the system boundary; reject unexpected data types and sizes.
- Use parameterized queries for all database interactions to prevent SQL injection.
- Apply output encoding to prevent XSS in web frontends.
- Implement CSRF protection on all state-changing endpoints.

## Data Protection

- Encrypt PII and sensitive data at rest using AES-256 or equivalent.
- Enforce TLS 1.2+ for all data in transit.
- Minimize PII exposure in logs, error messages, and API responses; mask or redact where possible.

## Dependency and Supply Chain

- Scan dependencies for known vulnerabilities in CI (e.g., `npm audit`, `pip-audit`, `trivy`, Checkmarx).
- Pin dependency versions and verify checksums or lock files.
- Address critical and high-severity vulnerabilities before merging.

## Logging and Auditing

- Log all security-relevant events: authentication attempts, authorization failures, privilege changes, data access.
- Never log secrets, tokens, passwords, or full PII.
- Maintain audit trails that are tamper-evident and centrally collected.

## Compliance

- Follow organizational AppSec policies (AppSoc, Checkmarx, Trivy scanning gates).
- Conduct threat modeling for new features or significant architecture changes.
- Document security decisions and accepted risks in Architecture Decision Records (ADRs).

## References

- Follow [copilot](copilot.instructions.md) for Copilot behavior rules.
- Follow [coding standards](coding.standard.instructions.md) for general coding rules.
