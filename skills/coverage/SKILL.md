---
name: coverage
description:
  "Evaluate test coverage and fill real gaps with high-value tests."
user-invocable: true
argument-hint: "[optional: file path or module to evaluate]"
---

# Coverage

## When to use

- You want to check whether recent work has enough test coverage
- A file or module looks fragile or under-tested
- You want to add tests without changing behavior

## Process

1. Intelligently locate changes using git, if no `$ARGUMENTS` from the
   user exists.
1. Read the code and the existing tests.
1. Identify realistic gaps: edge cases, failure paths, state changes,
   and integration points.
1. Add only the tests that would catch a real bug.
1. Run the relevant tests and confirm they pass.

## Verification

- The target area has clear scope
- New tests cover real risk, not coverage vanity
- The code under test stayed unchanged
- Tests pass

## Rules

- Focus on the smallest set of tests that meaningfully improves
  confidence.
- Add coverage for contract and failure-path behavior before edge-case
  trivia.
- If the target remains unclear and no current changes exist, ask before
  writing tests.
- Avoid writing tests just to raise a number.
- Avoid adding tests for trivial code or framework behavior.
- If the code already has strong test coverage, say so.
