---
name: spae-spec
description:
  Requirements Engineering for the SPAE framework. Distills requests
  into unambiguous requirements in SPEC.md.
user-invocable: true
argument-hint:
  "[optional-workstream-name] <requirement> — omit workstream name to
  force fresh workstream creation (e.g., 'user-auth add Google OAuth
  login')"
---

# Spec

**Your goal:** refine, synthesize, and distill the user request into a
full-fledged specification document in `SPEC.md`. Then update the
current symbolic link to point to the new `workstream` folder.

**Files to update:**

- `SPEC.md`
- Update current symbolic link to point to the new `workstream` folder.

## When to use

- Start a new `workstream`.
- Update requirements for an existing `workstream` (requires explicit
  `workstream` name).
- Define the "Normalized Truth" before task decomposition.

## Process

1. **Validate Input**:
   - Require an actionable user request.
   - Treat the leading token as the `workstream` name only if explicitly
     provided.
   - Request missing details if the prompt lacks an actionable request.
2. **Resolve Workstream**:
   - **Explicit Name**: Use `.spae/[workstream-name]/`.
   - **Omitted Name**: Create a fresh directory using a slug of the
     request text. Append a deterministic `disambiguator` (numeric
     suffix/timestamp) if the slug exists. Never reuse existing
     `workstreams`.
   - **CRITICAL**: Update `.spae/current` to point to
     `.spae/[workstream-name]`.
3. **Gather Context**: Read relevant codebase sections to align the spec
   with existing patterns.
4. **Metacognitive Oversight**: Invoke `vibe_check` (phase:
   `preparation`) with the drafted spec and prompt to prevent feature
   creep and speculative design.
5. **Generate Artifacts**:
   - Distill the request into a minimal, complete set of requirements.
   - Include only essential context for execution and verification.
   - Create/Overwrite `SPEC.md` with: Goal, Requirements, Testing
     Strategy, Out of Scope, and Assumptions.
   - Initialize `STATE.json` with
     `{"version": "1.0", "workstream": "[name]", "phase": "plan", "status": "active"}`.
6. **Complete**: Report the resolved `workstream` path, its origin
   (explicit vs. generated), and suggest the next step (`/plan`).

## Verification

- `.spae/[workstream-name]/SPEC.md` exists with distilled requirements.
- `.spae/[workstream-name]/STATE.json` exists with `phase: "plan"`.
- `.spae/current` symlink points to `.spae/[workstream-name]`.
- Omitted `workstream` names result in a newly created folder.

## Rules

- **Efficiency**: Optimize operations for token and context economy.
- **Design**: Reject speculative design; prefer codebase fit.
- **Artifacts**: Maintain exactly two artifacts: `STATE.json` and
  `SPEC.md`.
- **Content**: Write `SPEC.md` using concise, testable language for
  maximal signal and minimal tokens.
- **Scope**: Treat repository source code as read-only.
- **Modifications**: Only write `.spae/[workstream]/SPEC.md`,
  `.spae/[workstream]/STATE.json`, `.spae/current`, and necessary
  directory structures.
- **SYMLINK**: Ensure `.spae/current` points to
  `.spae/[workstream-name]`.
- **Isolation**: Never edit application code, tests, configuration
  files, docs, `PLAN.md`, or non-`SPAE` project files.
- **Completion**: Return `STATUS: SUCCESS` upon completion.
