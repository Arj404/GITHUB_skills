---
applyTo: "**/Dockerfile*,**/*.dockerfile,**/docker-compose*.{yml,yaml},**/.dockerignore"
---

# Docker Standards

## Base Images

- Use official, minimal base images: prefer `-slim` or `-alpine` variants (e.g., `python:3.12-slim`, `node:22-alpine`).
- Never use `latest` tag; always pin to a specific version (e.g., `python:3.12.4-slim-bookworm`).
- Prefer Alpine-based images only when all dependencies compile cleanly on musl libc; fall back to Debian `-slim` otherwise.
- Use `scratch` or `distroless` for final-stage images in compiled languages (Go, Rust, Java GraalVM native).

## Multi-Stage Builds

- Always use multi-stage builds to separate build-time and runtime layers.
- Name stages explicitly for clarity (e.g., `FROM node:22-alpine AS builder`, `FROM node:22-alpine AS runtime`).
- Install build tools (compilers, dev headers) only in the builder stage; never carry them into the runtime image.
- Copy only the required artifacts from the builder stage into the final image using `COPY --from=builder`.

## Layer Optimization

- Order instructions from least-frequently to most-frequently changing to maximize cache reuse.
- Copy dependency manifests (`requirements.txt`, `package.json`, `go.mod`) and install dependencies BEFORE copying application source.
- Combine related `RUN` commands with `&&` and `\` to minimize layer count.
- Clean up caches in the same `RUN` layer they are created (e.g., `rm -rf /var/cache/apk/* /root/.cache/pip`).
- Use `--no-cache` flag where available (e.g., `apk add --no-cache`, `pip install --no-cache-dir`).

## Fat-Free Images

- Include only what is needed to run the application; remove docs, man pages, test files, and build artifacts.
- Do not install debugging tools (`curl`, `wget`, `vim`) in production images; add them only in a separate debug target if needed.
- Use `.dockerignore` to exclude: `.git/`, `node_modules/`, `__pycache__/`, `*.md`, `tests/`, `.env`, IDE configs, build outputs.
- Audit final image size regularly; set a size budget per service (e.g., <100MB for Python APIs, <50MB for Node APIs).

## Security

- Run the application as a non-root user: create a dedicated user with `RUN addgroup/adduser` and switch with `USER`.
- Never store secrets, credentials, or `.env` files in the image; use runtime injection via environment variables or mounted secrets.
- Set `ENV PYTHONDONTWRITEBYTECODE=1` and `ENV PYTHONUNBUFFERED=1` for Python images.
- Scan images in CI with `trivy`, `grype`, or equivalent; fail the build on critical/high vulnerabilities.
- Use `COPY` over `ADD` unless extracting archives; `ADD` from remote URLs is forbidden.

## Health Checks

- Define a `HEALTHCHECK` instruction in every Dockerfile for production services.
- Example: `HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -f http://localhost:8080/health || exit 1`
- For Alpine/distroless images without `curl`, use a language-native health probe or `wget -q --spider`.

## Metadata

- Add `LABEL` instructions for: `maintainer`, `version`, `description`, and `org.opencontainers.image.*` standard labels.
- Set `WORKDIR` explicitly; never rely on the default working directory.
- Declare `EXPOSE` for all ports the service listens on (documentation, not enforcement).

## Docker Compose

- Use Compose for local development and multi-service orchestration.
- Pin the Compose file version or use the Compose Specification format.
- Define named volumes for persistent data; never mount host paths containing secrets.
- Use `depends_on` with `condition: service_healthy` for startup ordering.
- Provide `env_file` references pointing to a `.env.example` template (committed) and `.env` (gitignored).

## Example: Python Multi-Stage

```dockerfile
# --- Builder ---
FROM python:3.12-slim-bookworm AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- Runtime ---
FROM python:3.12-slim-bookworm AS runtime
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN addgroup --system app && adduser --system --ingroup app app
WORKDIR /app
COPY --from=builder /install /usr/local
COPY src/ ./src/
USER app
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')"
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080"]
```

## References

- Follow [devops](devops.instructions.md) for CI/CD and deployment pipeline standards.
- Follow [security](security.instructions.md) for image scanning and secrets management.
