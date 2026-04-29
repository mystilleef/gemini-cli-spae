---
name: spae-review
description:
  Optimization & Verification for the `SPAE` framework. Performs gap
  analysis on `PLAN.md`.
user-invocable: true
argument-hint: "[optional-workstream-name] e.g. 'user-auth'"
---

# Review (`SPAE`)

**Your goal:** Refine, `consolidate`, and optimize `PLAN.md` to address
identified gaps.

**Files to update:**

- `PLAN.md`
- `STATE.json`

## When to use

- When `SPEC.md` and `PLAN.md` exists and you need to address gaps in
  the plan.
- When `STATE.json` reaches `phase: review`.
- To optimize the plan before execution.

## Process

1. **Resolve `workstream`**:
   - If an optional `[workstream-name]` appears, use
     `.spae/[workstream-name]/`.
   - If omitted, follow `.spae/current` symlink.
2. **Gap analysis**:
   - Read `SPEC.md` and `PLAN.md`.
   - Read source code when needed for gap analysis, but keep repository
     code read-only.
   - Identify only concrete bugs, regressions, contract breaks, or weak
     verification steps that materially affect execution reliability.
3. **Optimization**:
   - Refine `PLAN.md` with the smallest useful changes based on
     findings.
   - Prefer concise deltas over broad narrative summaries.
   - **Metacognitive oversight (optional)**: If `vibe_check` is
     available AND you identify significant gaps, invoke it (phase:
     `review`) to assess proposed optimizations and prevent process
     bloat.
   - Report findings as `Must fix`, `Should fix`, or `Observations`.
4. **Update state**:
   - Update `STATE.json` phase to `build`.
   - Set `cursor.active_task_id` to the first task.
5. **Completion**: Report readiness for `/build`.

## Verification

- `PLAN.md` reflects optimizations and aligns with `SPEC.md`.
- `STATE.json` reaches `phase: build`.

## Rules

- Optimize all operations for agent, token, and context efficiency.
- Write review findings and `PLAN.md` refinements for maximal signal
  with minimal tokens and only essential context.
- Prevent process inflation; avoid turning this into a heavyweight gate.
- Focus on execution reliability.
- Treat repository source code as read-only during this phase.
- Only write `.spae/current/PLAN.md` and `.spae/current/STATE.json`.
- Don't modify `.gitignore` or any other non-`SPAE` project file.
- Never edit application code, tests, configuration files, docs,
  `SPEC.md`, or any other non-`SPAE` project file.
- STATUS: SUCCESS on completion.
