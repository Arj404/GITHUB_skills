---
applyTo: "**/*.java"
---

# Java Coding Standards

## 1. Object-Oriented Design

- **Immutability**: Prefer immutable objects. Use `final` fields and avoid setter methods. Use Records (`record`) for pure data carriers (Java 14+).
- **Composition over Inheritance**: Avoid deep inheritance hierarchies. Use interfaces to define behavior and composition to reuse logic.
- **Null Safety**: Avoid returning `null`. Use `Optional<T>` for methods that may not return a value. Do not use `Optional` as a parameter type or field type.

## 2. Modern Java Features

- Use `var` for local variables when the type is obvious from the right-hand side.
- Utilize the Streams API for complex collection transformations.
- Use enhanced `switch` expressions instead of classic `switch` statements (Java 14+).

## 3. Concurrency

- Prefer the `java.util.concurrent` package (e.g., `ExecutorService`, `CompletableFuture`) over raw `Thread` management.
- Minimize synchronized blocks. Prefer concurrent collections (`ConcurrentHashMap`) and atomic variables (`AtomicInteger`).
- When using Spring Boot, prefer `@Async` for asynchronous method execution.

## 4. Exceptions

- Use **unchecked exceptions** (`RuntimeException`) for application logic failures. Checked exceptions should only be used for recoverable, external environmental issues.
- Never catch `Exception` or `Throwable` generically unless at the top level for centralized logging.
- Always include context in exception messages.

## 5. Tooling & Ecosystem

- Use Maven or Gradle for dependency management.
- Format code using established conventions (e.g., Google Java Format).
- For enterprise applications, rely on Spring Boot conventions (e.g., Constructor injection over field injection with `@Autowired`).

## References
- Follow [coding standards](coding.standard.instructions.md) for universal naming, error handling, and DRY rules.
- Follow [testing standards](testing.instructions.md) for test organization and coverage rules.
- Follow [security standards](security.instructions.md) for secure coding practices.
- Follow [architecture principles](architecture.instructions.md) for module structure and design decisions.
