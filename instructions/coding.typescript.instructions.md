---
applyTo: "**/*.{ts,tsx}"
---

# TypeScript Coding Standards

## 1. Type Safety & Strict Mode

- **Strict Mode**: Always assume `tsconfig.json` has `"strict": true`. Do not write code that relies on implicit `any`.
- **`any` is forbidden**: Use `unknown` if the type is truly unknown, and narrow it down using type guards or Zod/Joi validation schemas.
- **Nullability**: Handle `null` and `undefined` explicitly. Prefer optional chaining (`?.`) and nullish coalescing (`??`).

## 2. Type System Features

- **Interfaces vs Types**: Prefer `interface` for public APIs, object shapes, and classes. Use `type` for unions, intersections, primitives, and utility types.
- **Discriminated Unions**: Use discriminated unions for modeling state machines or handling different payload types.
  ```typescript
  type Action = 
    | { type: 'LOADING' }
    | { type: 'SUCCESS'; data: string }
    | { type: 'ERROR'; error: Error };
  ```
- **Generic Constraints**: Always constraint generic types (`<T extends BaseType>`) to limit acceptable inputs and provide better IDE auto-complete.
- **Branded Types**: Use branded/opaque types for domain IDs to prevent accidental assignments of primitives (e.g., passing a `UserId` to a function expecting a `PostId`).
  ```typescript
  type UserId = string & { readonly __brand: unique symbol };
  ```

## 3. Module Resolution & Imports

- Use ES Modules (`import`/`export`) exclusively.
- Use explicit extensions in relative imports if the project relies on Node's native ESM resolution (e.g., `import { foo } from './foo.js'`).
- Group imports:
  1. Built-in modules (e.g., `node:fs`)
  2. Third-party dependencies
  3. Absolute project paths (e.g., `@/components/...`)
  4. Relative paths

## 4. Concurrency and Async

- Prefer `async/await` over raw Promises (`.then().catch()`).
- Use `Promise.all` or `Promise.allSettled` for concurrent operations. Do not await inside loops unless sequence matters.

## 5. Tooling

- Ensure compatibility with tools like `tsc`, `ESLint` (`@typescript-eslint`), and `Prettier`.
- Do not use `@ts-ignore`. If a compiler error must be bypassed, use `@ts-expect-error` with a comment explaining why.
