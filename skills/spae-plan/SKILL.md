---
name: spae-plan
description:
  Task Decomposition for the `SPAE` framework. Decomposes `SPEC.md` into
  a `DAG` of atomic tasks in `PLAN.md`.
user-invocable: true
argument-hint: "[optional-workstream-name] e.g. 'user-auth'"
---

# Goal

**Your goal:** decompose the requirements in the `SPEC.md` file into a
`DAG` of atomic tasks and create a `PLAN.md` file.

**Files to update:**

- `PLAN.md`
- `STATE.json`

## When to use

- When `SPEC.md` exists and you need a new plan.
- When `STATE.json` reaches `phase: plan`.

## Process

1. **Resolve `workstream`**:
   - If an optional `[workstream-name]` appears, use
     `.spae/[workstream-name]/`.
   - If omitted, follow `.spae/current` symlink.
2. **Read `spec`**: Read `SPEC.md` to understand requirements.
3. **Decompose tasks**:
   - Create `PLAN.md` with a sequence of atomic tasks.
   - Keep each task high-signal and include only context needed for safe
     execution.
   - Avoid explanatory padding or repeated `SPEC.md` content.
   - Each task must include: Context, Acceptance Criteria, and
     Verification steps.
   - Ensure each task leaves the system in a working state.
4. **Metacognitive oversight (optional)**: If `vibe_check` is available,
   invoke it (phase: `preparation`) with the drafted `PLAN.md` and
   `SPEC.md` to ensure task atomicity and vertical slicing.
5. **Update state**:
   - Initialize `tasks` registry in `STATE.json` (for example,
     `T-001: todo`).
   - Update `phase` to `review`.
6. **Completion**: Report task count and next step (`/review`).

## Verification

- `PLAN.md` exists with atomic, verifiable tasks.
- `STATE.json` reflects the new tasks and `phase: "review"`.

## Rules

- Optimize all operations for agent, token, and context efficiency.
- Write `PLAN.md` for maximal signal with minimal tokens and only
  essential context.
- Order tasks by dependency and risk.
- Slice vertically (functional slices).
- Treat repository source code as read-only during this phase.
- Only write `.spae/current/PLAN.md` and `.spae/current/STATE.json`.
- Never edit application code, tests, configuration files, docs,
  `SPEC.md`, or any other non-`SPAE` project file.
- STATUS: SUCCESS on completion.
