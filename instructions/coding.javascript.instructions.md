

---
applyTo: "**/*.{js,ts,jsx,tsx,mjs,cjs}"
---

# JavaScript / TypeScript Standards

## Style and Structure

- Use ES6+ syntax: `const`/`let` (never `var`), arrow functions, destructuring, template literals, optional chaining.
- Prefer TypeScript for all new code; use strict mode (`"strict": true`) in `tsconfig.json`.
- Define explicit interfaces/types for all function parameters, return types, and data structures.
- Use `async/await` over raw Promises and callbacks; avoid callback nesting.

## Patterns

- Prefer immutable data: use `const`, `Object.freeze()`, spread operators, and `Readonly<T>`.
- Avoid global mutable state; use module-scoped constants or a well-defined state management pattern.
- Use ESM (`import`/`export`) over CommonJS (`require`/`module.exports`) for new projects.
- Prefer named exports over default exports for discoverability and refactoring.

## Dependencies

- Manage dependencies in `package.json` with exact or caret-pinned versions.
- Run `npm audit` or equivalent regularly; address critical vulnerabilities immediately.
- Avoid large dependency trees for trivial functionality; prefer native APIs when available.

## Testing

- Use `vitest`, `jest`, or `mocha` as the test framework.
- Co-locate test files with source (e.g., `module.test.ts`) or place in a `test/` mirror directory.
- Use `msw` or similar for mocking network requests in tests.

## Linting and Formatting

- Enforce linting with `eslint` and formatting with `prettier`.
- Enable TypeScript strict checks: `noImplicitAny`, `strictNullChecks`, `noUnusedLocals`.

## References

- Follow [coding standards](coding.standard.instructions.md) for universal coding rules.
- Follow [testing](testing.instructions.md) for testing practices.
