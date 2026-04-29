# SPAE framework

A Gemini CLI configuration implementing the **SPAE** (State-Persistent
Atomic Execution) framework—a structured, agent-first workflow for
high-quality, predictable `LLM` outputs.

The configuration symlinks to `~/.gemini/` and organizes agents, skills,
hooks, and a knowledge base around a four-phase workflow: **spec → plan
→ review → build**.

---

## What `SPAE` does

`SPAE` prevents context drift, hallucination, and scope creep by:

- Decomposing requests into atomic, independently verifiable tasks
- Persisting state in external artifacts (not conversational memory)
- Enforcing phase boundaries so each agent reads only what it needs
- Allowing any harness (Gemini, Claude, OpenAI) to resume work at any
  point

---

## Framework design

- **Harness agnostic**—use any combination of Gemini, Claude, OpenAI, or
  Codex at each phase
- **Zero-knowledge resumption**—any agent resumes any `workstream` by
  reading the artifacts
- **Atomic execution**—every task stays small enough to verify in a
  single cycle
- **Human oversight**—you invoke each phase; nothing progresses
  automatically

---

## Prerequisites

- **Gemini CLI** (nightly build—`settings.json` uses experimental
  features)
- **RTK** (optional)—install [rtk-ai/rtk](https://github.com/rtk-ai/rtk)
  to enable the token-efficiency hook

---

## Installation

```bash
# 1. Clone or copy this repo to ~/.gemini
git clone <repo-url> ~/.gemini

# 2. Enable SYSTEM.md (add to shell profile)
export GEMINI_SYSTEM_MD="~/.gemini/SYSTEM.md"

# 3. Add SPAE artifacts to your global .gitignore
echo ".spae/" >> ~/.gitignore_global
```

> Symlink alternative: `ln -s ~/Projects/gemini-cli-spae ~/.gemini`

---

## The `SPAE` workflow

Run each phase in order. Agents read only their designated inputs and
write only their designated outputs.

### Phase 1: Spec

The scout agent distills your request into unambiguous requirements.

```
/run @scout implement <your feature or request>
```

**Output:** `.spae/<workstream>/SPEC.md`, `STATE.json` (phase: plan)

---

### Phase 2: Plan

The planner decomposes `SPEC.md` into a directed acyclic graph (`DAG`)
of atomic tasks.

```
/run @planner
```

**Output:** `.spae/<workstream>/PLAN.md`, `STATE.json` (phase: review)

---

### Phase 3: Review

The reviewer performs a gap analysis on `PLAN.md` and optimizes it.

```
/run @reviewer
```

**Output:** Optimized `PLAN.md`, `STATE.json` (phase: build)

---

### Phase 4: Build

Choose one execution mode per `workstream`:

| Command          | Agent      | Use When                                         |
| ---------------- | ---------- | ------------------------------------------------ |
| `/run @builder`  | `builder`  | Iterating carefully, one task at a time          |
| `/run @tdder`    | `tdder`    | Behavioral changes that need test coverage first |
| `/run @executor` | `executor` | Plan looks solid; execute all tasks at once      |

Repeat `/run @builder` or `/run @tdder` until `PLAN.md` marks all tasks
complete.

---

## Artifacts

All artifacts live in `.spae/<workstream>/` and **must not be
committed**.

| File         | Purpose                                            |
| ------------ | -------------------------------------------------- |
| `STATE.json` | Execution cursor—tracks phase and active task      |
| `SPEC.md`    | Normalized requirements—immutable during execution |
| `PLAN.md`    | Atomic task graph—immutable during execution       |

---

## Contents

| Directory   | Contents                                                                                                                              |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `agents/`   | scout, planner, reviewer, builder, `tdder`, executor + utility agents                                                                 |
| `skills/`   | Reusable procedures: spae-spec, spae-plan, spae-review, spae-build, spae-tdd, spae-execute, refactor, coverage, auto-commit, and more |
| `kbase/`    | Protocol guides: `SPAE` framework, efficiency, E-Prime, git, shell scripting, and more                                                |
| `hooks/`    | `context-orchestrator.sh` (safety baseline) and `rtk-hook-gemini.sh` (token efficiency)                                               |
| `commands/` | `/run` subagent orchestrator and `/syd` directive inspector                                                                           |

---

## Tips

- Read `.spae/<workstream>/PLAN.md` between build cycles to confirm task
  completion
- Use `@worker` for ad-hoc tasks outside a formal `SPAE` `workstream`:
  ```
  /run @worker use troubleshoot skill to fix the biome lint issues
  ```
- Use `@commit` after a build cycle for atomic, well-formed git commits:
  ```
  /run @commit
  ```
- Consult `kbase/spae-framework.md` for the full protocol specification
