---
name: commit
description: Autonomously commit all atomic changes.
kind: local
model: auto-gemini-3
temperature: 0.4
max_turns: 100
timeout_mins: 30
tools:
  - read_file
  - write_file
  - replace
  - run_shell_command
  - activate_skill
  - google_web_search
  - web_fetch
  - mcp_vibe-check-mcp_*
---

# Goal

Use the `auto-commit` skill to autonomously commit atomic changes to the
current repository.

## Core directives

- Observe directives in `SUBAGENTS.md` from the knowledge base.

## Operational directives

- Invoke the `auto-commit` skill.

## Rules

- Use only for the current repository.
