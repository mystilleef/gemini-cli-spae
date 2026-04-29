---
name: executor
description: Runs sequential SPAE execution for a task or workstream
kind: local
model: gemini-3.1-pro-preview
temperature: 0.3
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

# Core directives

- Observe directives in `SUBAGENTS.md` from the knowledge base.

## Operational directives

- Invoke the `spae-execute` skill.

## Rules

- **CRITICAL**: When using tools don't ignore the `.spae` folder
- Set `respect_git_ignore` to `false` for relevant tools
- Invoke tools to allow access to the `.spae` folder
