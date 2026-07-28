# Coding Style

## Immutability (CRITICAL)

ALWAYS create new objects, NEVER mutate existing ones:

```
// Pseudocode
WRONG:  modify(original, field, value) → changes original in-place
CORRECT: update(original, field, value) → returns new copy with change
```

Rationale: Immutable data prevents hidden side effects, makes debugging easier, and enables safe concurrency.

## Core Principles

- KISS/YAGNI: do the simplest thing that works. Don't build features or abstractions before they are needed.
- DRY: extract shared logic when repetition is real, not speculative.

## Error Handling & Validation

- Validate at system boundaries (user input, external APIs, file/network I/O): schema-based where available, fail fast with clear messages, never trust external data.
- Trust internal code and framework guarantees. Don't add error handling or fallbacks for scenarios that cannot happen.
- Never silently swallow errors. User-friendly messages in UI-facing code; detailed error context in server logs.
