---
name: spae-tdd
description:
  "Use test-first development for behavioral changes. Write a failing
  test, make it pass, then simplify."
user-invocable: true
argument-hint: "[optional-workstream-name] e.g. 'user-auth'"
---

# Test-driven development

Your goal: execute exactly one atomic task from the
`.spae/[workstream]/PLAN.md` file using test-first development.

## When to use

- After `/review` completes and `STATE.json` reaches `phase: build`.
- To execute the next task in the plan.

## Process

1. **Resolve Workstream**: Determine the `.spae/` directory path using
   the optional `[workstream-name]` or the `current` symlink.
2. **Identify Task**: Locate the `cursor.active_task_id` in `STATE.json`
   and retrieve task details from `PLAN.md`.
3. **Execute TDD Cycle**: Write a failing test, `implement` the minimal
   code to pass, and refactor while maintaining green tests.
4. **Verify and Finalize**: Run the full relevant test suite to ensure
   stability.
5. **Update State**: Mark the task as `done`, advance the
   `cursor.active_task_id`, and refresh `metrics` in `STATE.json`.
6. **Report Outcome**: Provide a concise summary of the task result and
   verification evidence.

## Verification

- Confirm fulfillment of acceptance criteria and verification steps.
- Ensure a failing-then-passing test validates the change.
- Verify that tests focus on behavior, not implementation.
- `Validate` a passing state for the full relevant test suite.
- Confirm accurate `STATE.json` updates.

## Rules

- Execute exactly one atomic task per invocation with minimal necessary
  edits.
- Write failing tests before implementation code; skip `TDD` for
  non-behavioral work.
- `Prioritize` behavioral testing over internals and use mocks
  sparingly.
- Include failure path tests when relevant to behavior.
- Maintain existing contracts unless the task explicitly mandates
  changes.
- Exercise exclusive authority over source code edits while avoiding
  `PLAN.md` modifications.
- Optimize all operations for agent, token, and context efficiency.
- Report blockers and halt immediately upon task failure.
- Return `STATUS: SUCCESS` only after full task completion.
