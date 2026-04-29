# Vibe check directives

## Core philosophy

Treat `vibe_check` as a **collaborative partner** and **pattern
interrupt** mechanism. It provides essential `metacognitive` oversight
to break "pattern inertia" and ensure alignment.

## Operational directives

### 1. Strategic invocation

Invoke `vibe_check` autonomously at these critical checkpoints:

- **Post-Preparation**: Before executing complex `roadmaps`.
- **High Complexity**: When task ambiguity or difficulty increases.
- **System Modification**: Before applying significant changes to the
  codebase or architecture.

### 2. Contextual execution

- **Full Context**: ALWAYS include the complete user prompt in the
  `vibe_check` call.
- **Phase Awareness**: Explicitly define the `phase` parameter:
  - `preparation`: Strategy formulation.
  - `implementation`: Code writing/modification.
  - `review`: Verification and testing.

### 3. Feedback integration

- **Priority Interrupt**: Treat feedback as a high-priority signal to
  recalibrate, not just data.
- **Collaborative Adaptation**: Adapt your approach based on feedback
  immediately.
- **Override Protocol**: Only override feedback if irrelevant;
  otherwise, assume it corrects a blind spot.

### 4. Continuous learning

- **Loop Closure**: After resolving issues identified by `vibe_check`,
  use `vibe_learn` to log the error pattern.
- **Self-Correction**: Use these logs to refine future performance and
  avoid repeating specific error patterns.

## Violation patterns

Treat these as violations:

- **Missed check**: No `vibe_check` before complex planning, high-risk
  edits, or major architecture changes.
- **Unneeded check**: `vibe_check` used on minor, routine, unambiguous,
  deterministic tasks.
- **Missing context**: Call lacks full user prompt, goal, or key
  constraints.
- **Wrong phase**: Incorrect or missing `phase`
  (`preparation|implementation|review`).
- **Ignored feedback**: Guidance not applied or explicitly rejected with
  rationale.
- **Checkbox use**: `vibe_check` used ritualistically, not as a real
  pattern interrupt.
- **No learning**: Repeated/reusable issue resolved without
  `vibe_learn`.

### Violation response

1. Pause.
2. Name the violation.
3. Re-run `vibe_check` with full context + correct phase.
4. Apply guidance or record explicit rejection reason.
5. Log reusable pattern via `vibe_learn`.

## System prompt integration (reference)

```markdown
1. Treat `vibe_check` as a pattern interrupt for course correction.
2. Use at strategic points (Prepare -> Check -> Act).
3. Include full user prompt and current phase.
4. Chain `vibe_learn` to record resolved error patterns.
```
