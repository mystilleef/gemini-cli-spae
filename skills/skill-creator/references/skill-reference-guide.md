# Skill `master` guide

**`GOAL`**: provide a single source of truth for creating and updating
agent skills.

**`NOTE`**: this guide targets agent consumption. It contains zero
fluff. Agents must strictly adhere to these rules.

---

## 1. Core Protocol

### 1.1 Status codes

**Rule**: the first line of output must contain `STATUS: message`.

| Status    | Meaning                | Exit Code | Usage                                       |
| :-------- | :--------------------- | :-------- | :------------------------------------------ |
| `SUCCESS` | Completed with changes | 0         | Work done, proceed to next step.            |
| `WARN`    | Completed, no changes  | 0         | Nothing to do, skip cleanup/optional steps. |
| `ERROR`   | Failed                 | 1         | Critical failure, halt immediately.         |

**Extended codes** (Domain-specific): `APPROVED`, `REJECTED_EDIT`,
`REJECTED_ABORT` (for example, for user interaction).

---

## 2. Skill structure template

**File**: `skills/<skill-name>/SKILL.md`

```markdown
---
name: skill-name
description: Brief description (1-3 sentences).
user-invocable: true
argument-hint: "<hint for arguments, e.g., 'task reference'>"
---

# [Readable Title]

## When to use

- [Scenario 1 when to invoke this skill]
- [Scenario 2 when to invoke this skill]

## Process

1. [Step 1 action]
2. [Step 2 action]
3. [Step 3 action]

## Verification

- [Condition that must be true to consider the task complete]
- [Tests pass, behavior matches request, etc.]

## Rules

- Optimize all operations for agent, token, and context efficiency.
- [Specific constraint 1]
- [Specific constraint 2]
```

---

## 3. Component templates

### 3.1 Efficiency rules

Include these rules in the `Rules` section to ensure token and context
efficiency:

```markdown
- Optimize all operations for agent, token, and context efficiency.
- Batch operations on file groups; avoid individual file processing.
- Use parallel execution when possible.
- Target only relevant files.
- Reduce token usage.
```

---

## 4. Orchestration patterns

### 4.1 `Simple` skill (linear)

**Use when**: single responsibility, no sub-skills, 3-5 steps.

```markdown
## Process

1. Step 1 action
2. Step 2 action
3. Step 3 action
```

### 4.2 Sequential orchestration (looping)

**Use when**: fixed order, status capture, automatic loop control.

```markdown
## Process

1. **Prerequisite**: Check [condition]. If met, skip to step N.
2. **Sub-skill**: Invoke `sub-skill-1`. Capture status (`SUCCESS`,
   `WARN`, `ERROR`).
   - `ERROR`: Halt and report.
   - `WARN`: [Action].
   - `SUCCESS`: Continue.
3. **Loop Control**: Check for remaining work. If work remains, loop
   back to step 2.
4. **Final Status**: Report summary.
```

### 4.3 Conditional orchestration (branching)

**Use when**: dependencies, optional steps, smart initialization.

```markdown
## Process

1. **Prerequisite Check**: Check if [resource] exists. If missing,
   invoke `init-skill`.
   - `ERROR`: Halt.
   - `SUCCESS`/`WARN`: Continue.
2. **Main Operation**: Invoke `main-skill`. Capture status.
   - `WARN` (no work): Skip cleanup, go to completion.
   - `SUCCESS`: Continue to cleanup.
3. **Cleanup (Conditional)**: Only run if step 2 was `SUCCESS`. Invoke
   `cleanup-skill`.
4. **Completion**: Report summary.
```

---

## 5. Scripting standards

### 5.1 POSIX compliance

Adhere to the POSIX-compliant shell scripting guide in the knowledge
base when writing shell scripts.

- `$HOME/.gemini/kbase/shell-scripting-guide.md`

**Fallback**: when the guide remains unavailable, apply standard POSIX
best practices:

- Use `#!/bin/sh`.
- Set `set -eu`.
- Quote all variables.
- Use `$(...)` for command substitution.
- Avoid bash-isms (for example, `[[ ]]`, `local`, associative arrays).

---

## 6. Anti-patterns (strict prohibitions)

1.  **`God` skill**: Doing >1 verb (for example, "Stage and commit").
    **Fix**: Split into sub-skills.
2.  **Implicit dependencies**: Assuming files exist. **Fix**: Explicit
    checks with `ERROR` exit.
3.  **Silent failures**: Exiting 0 without status. **Fix**: Always
    `echo "STATUS: msg"`.
4.  **Format chaos**: Mixing headers. **Fix**: Use the standard
    `When to use`, `Process`, `Verification`, `Rules` format.
5.  **Inefficient loops**: Processing files individually. **Fix**: Batch
    operations.
6.  **Blind orchestration**: Ignoring sub-skill status. **Fix**: Capture
    and handle `SUCCESS`/`WARN`/`ERROR`.
