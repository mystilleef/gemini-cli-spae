---
name: spae-execute
description:
  Comprehensive Execution for the `SPAE` framework. Executes all tasks
  from `PLAN.md` sequentially in a single invocation.
user-invocable: true
argument-hint: "[optional-workstream-name] e.g. 'user-auth'"
---

# Execute (`SPAE`)

Your goal: execute all tasks from the `.spae/[workstream]/PLAN.md` file
in a single invocation.

## When to use

- After `/review` completes and `STATE.json` reaches `phase: build`.
- To execute all remaining tasks in the plan sequentially for low-risk
  or routine `workstreams`.

## Process

1. **Resolve `workstream`**:
   - If an optional `[workstream-name]` appears, use
     `.spae/[workstream-name]/`.
   - If omitted, follow `.spae/current` symlink.
2. **Execution Loop**:
   - Read `STATE.json` to find `cursor.active_task_id`.
   - Read the corresponding task details from `PLAN.md`.
   - **Execute task**:
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
   - **Update state**:
     - Mark task as `done` in `STATE.json`.
     - Advance `cursor.active_task_id` to the next task.
     - Update `metrics`.
   - **Repeat**: Continue the loop for the next task until all tasks
     reach `done`.
3. **Completion**: Report the outcome, key verification evidence for the
   completed plan, and final state.

## Verification

- All task acceptance criteria met.
- All verification steps pass.
- `STATE.json` updated correctly, showing all tasks as `done`.

## Rules

- Optimize all operations for agent, token, and context efficiency.
- Execute tasks with maximal signal, minimal edits, and only essential
  context.
- Execute all tasks sequentially in a single invocation.
- This phase holds exclusive authority to edit source code and other
  non-`SPAE` project files.
- Never edit `PLAN.md` during this phase.
- If any task fails, report the blocker, halt execution, and leave
  remaining tasks as `todo`.
- STATUS: SUCCESS on completion of all tasks.
