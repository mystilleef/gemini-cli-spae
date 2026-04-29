---
name: spae-build
description:
  Atomic Execution for the `SPAE` framework. Executes exactly one atomic
  task from `PLAN.md`.
user-invocable: true
argument-hint: "[optional-workstream-name] e.g. 'user-auth'"
---

# Build (`SPAE`)

Your goal: execute exactly one atomic task from the
`.spae/[workstream]/PLAN.md` file.

## When to use

- After `/review` completes and `STATE.json` reaches `phase: build`.
- To execute the next task in the plan.

## Process

1. **Resolve `workstream`**:
   - If an optional `[workstream-name]` appears, use
     `.spae/[workstream-name]/`.
   - If omitted, follow `.spae/current` symlink.
2. **Identify task**:
   - Read `STATE.json` to find `cursor.active_task_id`.
   - Read the corresponding task details from `PLAN.md`.
3. **Execute task**:
   - Write the smallest useful slice.
   - Use the smallest useful implementation change set that satisfies
     the active task.
   - Read and edit only files required for the active task.
   - Avoid incidental refactors, cleanup, or adjacent improvements
     unless the task explicitly requires them.
   - **Metacognitive oversight (optional)**: If `vibe_check` is
     available AND the task involves high complexity or system
     modification, invoke it (phase: `implementation`) to verify
     alignment with task boundaries.
   - Add tests and run project checks.
   - Keep verification focused on the task's acceptance criteria and
     stated checks.
   - Verify outcome using the steps in `PLAN.md`.
4. **Update state**:
   - Mark task as `done` in `STATE.json`.
   - Advance `cursor.active_task_id` to the next task.
   - Update `metrics`.
5. **Completion**: Report only the task outcome, key verification
   evidence, and next task ID or blocker.

## Verification

- Task acceptance criteria met.
- Verification steps pass.
- `STATE.json` updated correctly.

## Rules

- Optimize all operations for agent, token, and context efficiency.
- Execute the active task with maximal signal, minimal edits, and only
  essential context.
- Execute exactly one atomic task per invocation.
- This phase holds exclusive authority to edit source code and other
  non-`SPAE` project files.
- Never edit `PLAN.md` during this phase.
- If a task fails, report the blocker and halt.
- STATUS: SUCCESS on completion.
