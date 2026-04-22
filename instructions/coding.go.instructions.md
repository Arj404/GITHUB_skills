---
applyTo: "**/*.go"
---

# Go Standards

## Style and Structure

- Follow [Effective Go](https://go.dev/doc/effective_go) and the official Go style guide; enforce with `gofmt` or `goimports`.
- Use short, clear variable names in small scopes (`i`, `ctx`, `err`) and descriptive names in larger scopes.
- Add doc comments on all exported types, functions, and packages starting with the identifier name.
- Prefer value receivers unless the method needs to mutate state or the struct is large; be consistent per type.

## Patterns

- Accept interfaces, return concrete types — keep interfaces small (1–3 methods).
- Use `context.Context` as the first parameter for functions involving I/O, cancellation, or deadlines.
- Prefer table-driven patterns for repetitive logic and switch statements over long if-else chains.
- Use goroutines and channels for concurrency; protect shared state with `sync.Mutex` or `sync.RWMutex` when channels are impractical.
- Prefer `errors.Is` / `errors.As` for error inspection; wrap errors with `fmt.Errorf("context: %w", err)` to preserve the chain.

## Dependencies

- Use Go modules (`go.mod` / `go.sum`) for dependency management; pin versions explicitly.
- Run `go mod tidy` before committing to remove unused dependencies.
- Prefer the standard library over third-party packages for common tasks (HTTP, JSON, crypto, testing).
- Vet imports with `go vet` and audit with `govulncheck` regularly.

## Testing

- Use the built-in `testing` package; place tests in the same package or a `_test` package for black-box testing.
- Use `testify` or table-driven tests with subtests (`t.Run`) for clear, maintainable test cases.
- Use `httptest` for HTTP handler tests and `gomock` or hand-rolled fakes for interface mocking.
- Run race detection in CI with `go test -race ./...`.

## Linting and Analysis

- Enforce linting with `golangci-lint` using a shared `.golangci.yml` configuration.
- Enable key linters: `govet`, `staticcheck`, `errcheck`, `gosec`, `revive`.
- Run `go vet ./...` as a minimum quality gate in CI.

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [testing](testing.instructions.md) for testing practices.
