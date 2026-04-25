---
applyTo: "**/*.rs"
---

# Rust Coding Standards

## 1. Borrowing & Ownership

- Prefer references (`&T`, `&mut T`) over taking ownership unless the function must consume the value or transfer it to another thread.
- Avoid unnecessary `.clone()`. Use it only when an actual copy is semantically required or for resolving borrowing conflicts where the performance hit is negligible.
- Use lifetimes explicitly only when the compiler cannot infer them.

## 2. Error Handling

- Always return `Result<T, E>` for recoverable errors. Never `panic!` or `unwrap()` in production logic unless the failure is truly an unrecoverable bug in the program logic.
- Use the `?` operator for clean error propagation.
- Use `thiserror` for library error types, and `anyhow` for application-level error bubbling.

## 3. Concurrency

- Use `tokio` for async runtimes unless targeting `no_std` or specialized environments.
- Prefer message passing (channels) over shared state.
- When sharing state is required, wrap it in `Arc<Mutex<T>>` or `Arc<RwLock<T>>`, keeping lock durations as short as possible.

## 4. Traits and Generics

- Use traits to define shared behavior. Avoid deep trait inheritance trees.
- Prefer static dispatch (`impl Trait` or generics with bounds) for performance. Use dynamic dispatch (`Box<dyn Trait>`) only when storing heterogeneous types in a collection.

## 5. Tooling

- Code must pass `cargo fmt` without changes.
- Code must pass `cargo clippy` without warnings. Address clippy warnings appropriately rather than allowing them globally.

## References
- Follow [coding standards](coding.standard.instructions.md) for universal naming, error handling, and DRY rules.
- Follow [testing standards](testing.instructions.md) for test organization and coverage rules.
- Follow [security standards](security.instructions.md) for secure coding practices.
