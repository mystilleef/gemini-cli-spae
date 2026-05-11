# State-persistent atomic execution framework

A Gemini CLI configuration implementing the **SPAE** (State-Persistent
Atomic Execution) framework—a structured, agent-first workflow for
high-quality, predictable `LLM` outputs.

The configuration symlinks to `~/.gemini/` and organizes agents, skills,
hooks, and a knowledge base around a five-phase workflow: **spec → plan
→ inspect → execution → verify**.

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
- **Context Mode** (optional)—install
  [mksglu/context-mode](https://github.com/mksglu/context-mode) to
  enable the context-window protection hook and knowledge base state
  management

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

The spec agent distills your request into unambiguous requirements.

```
/run @spec implement <your feature or request>
```

**Output:** `.spae/<workstream>/SPEC.md`, `STATE.json` (phase: plan)

---

### Phase 2: Plan

The planner decomposes `SPEC.md` into a directed acyclic graph (`DAG`)
of atomic tasks.

```
/run @plan
```

**Output:** `.spae/<workstream>/PLAN.md`, `STATE.json` (phase: inspect)

---

### Phase 3: Inspect

The inspector performs a gap analysis on `PLAN.md` and optimizes it.

```
/run @inspect
```

**Output:** Optimized `PLAN.md`, `STATE.json` (phase: build)

---

### Phase 4: Execution

Choose one execution mode per `workstream`:

<!-- prettier-ignore -->
| Command | Agent | Use |
| --- | --- | --- |
| `/run @build` | `build` | One task per cycle |
| `/run @tdd` | `tdd` | Behavioral changes needing tests first |
| `/run @execute` | `execute` | Execute all tasks at once |

Repeat `/run @build` or `/run @tdd` until `PLAN.md` marks all tasks
complete.

---

### Phase 5: Verify

The arbiter compares the implementation against `SPEC.md`.

```
/run @verify
```

**Output:** `STATE.json` (status: completed) or `VERIFY.md` (if gaps
found)

---

## Non-`SPAE` agents

See `agents` folder for available agents.

### Troubleshoot

Use the troubleshoot agent when a concrete failure needs systematic
investigation and repair. It invokes the `troubleshoot` skill to
observe, hypothesize, test, fix, and verify the issue.

```
/run @troubleshoot fix the biome lint issues
```

### Work

Use the work agent for ad-hoc tasks outside a formal `SPAE`
`workstream`. It gathers context from the request, discussion, project,
and environment, then performs the task with the refined context.

```
/run @work update the README examples
```

### Commit

Use the commit agent after a build cycle or focused edit to create
atomic, well-formed git commits for the current repository. It invokes
the `auto-commit` skill.

```
/run @commit
```

### Specialized agents

- **`@coverage`**: Analyzes and improves test coverage
- **`@document`**: Generates and maintains documentation
- **`@inspect`**: Analyzes code structure and architecture
- **`@purify`**: Simplifies code and removes redundancies
- **`@query`**: Interrogates the codebase and knowledge base
- **`@refactor`**: Executes structural code improvements
- **`@verify`**: Validates task completion and correctness

---

## Artifacts

The framework stores all artifacts in `.spae/<workstream>/`. Add
`.spae/` to your global `.gitignore` to prevent committing them.

| File         | Purpose                                            |
| ------------ | -------------------------------------------------- |
| `STATE.json` | Execution cursor—tracks phase and active task      |
| `SPEC.md`    | Normalized requirements—immutable during execution |
| `PLAN.md`    | Atomic task graph—immutable during execution       |
| `VERIFY.md`  | Ephemeral signal—created when verification fails   |

---

## Contents

| Path        | Contents                                                |
| ----------- | ------------------------------------------------------- |
| `agents/`   | Core `SPAE`, troubleshooting, worker, and commit agents |
| `skills/`   | Specialized workflows (markdown, shell, review, skills) |
| `kbase/`    | Protocols (efficiency, E-Prime, UI/UX, `SPAE`, context) |
| `hooks/`    | Safety, token-efficiency, and context-window hooks      |
| `commands/` | `/run` subagent orchestrator and `/syd` inspector       |

---

## Tips

- Read `.spae/<workstream>/PLAN.md` between build cycles to confirm task
  completion
- Consult `kbase/spae-framework.md` for the full protocol specification
