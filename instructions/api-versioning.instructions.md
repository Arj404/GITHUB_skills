---
applyTo: "**/*.{ts,js,py,go,java,rs,yaml,yml,json}"
---

# API Versioning Standards

## 1. Versioning Strategy

- **Always version your API from day one.** Do not release an unversioned public API.
- Use **URI path versioning** as the primary strategy: `/api/v1/`, `/api/v2/`.
  - This is explicit, easy to route, and highly visible in logs and documentation.
- Avoid header-based versioning for public APIs as it reduces discoverability.
- Version numbers are **integers only** (e.g., `v1`, `v2`). Do not use semver or dates in the URI path.

## 2. Breaking vs. Non-Breaking Changes

### Non-Breaking Changes (safe to deploy without a new version)
- Adding a new optional request field.
- Adding a new response field.
- Adding a new endpoint.
- Adding a new enum value (only safe if clients are written to handle unknown values).
- Bug fixes that align behavior with documented specs.

### Breaking Changes (require a new API version)
- Removing or renaming a request or response field.
- Changing a field type (e.g., `string` → `int`).
- Changing the HTTP method of an existing endpoint.
- Changing the URL path of an existing endpoint.
- Changing or removing a required request field.
- Making an optional field required.
- Adding new required request fields.

## 3. Deprecation Lifecycle

When a version must be deprecated, follow this policy:

1. **Announce**: Communicate the deprecation date to consumers with at least **6 months notice** for external APIs, and **3 months** for internal APIs.
2. **Signal via Headers**: All endpoints in a deprecated version MUST return the following response headers:
   - `Deprecation: true`
   - `Sunset: <RFC 7231 date>` — the exact date the endpoint will be decommissioned (e.g., `Sunset: Sat, 31 Dec 2025 23:59:59 GMT`).
   - `Link: <https://api.example.com/docs/migrate>; rel="deprecation"` — link to the migration guide.
3. **Log**: Log a warning for every request received on a deprecated endpoint to measure traffic drop-off.
4. **Sunset**: After the Sunset date, return `HTTP 410 Gone` with a body explaining where to migrate.

## 4. API Evolution Strategies

- **Additive by Default**: Design schemas to allow future additions (e.g., avoid `additionalProperties: false` in strict JSON Schema for request bodies; allow unknown fields on the response side in client SDKs).
- **Field Expansion Pattern**: When changing a field's behavior, keep the old field and add a new one (e.g., `amount_cents` → `amount`). Deprecate the old field via response body field-level `deprecated: true` in your OpenAPI spec.
- **Versioned Contracts**: Store OpenAPI specs per version at `docs/api/v1/openapi.yaml`, `docs/api/v2/openapi.yaml`. Generate code and docs from these specs.

## 5. Documentation Requirements

- Every API version must have a corresponding OpenAPI 3.1 spec.
- Deprecated fields MUST be marked `deprecated: true` in the OpenAPI spec.
- The migration guide from `vN` to `vN+1` must be published before the deprecation of `vN` is announced.

## References

- Follow [architecture](architecture.instructions.md) for API design, module structure, and separation of concerns.
- Follow [security](security.instructions.md) for authentication requirements on all versioned endpoints.
