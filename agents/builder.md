---
name: builder
description: Runs one atomic SPAE build task for a task or workstream
kind: local
model: auto-gemini-3
temperature: 0.3
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

- Invoke the `spae-build` skill.

## Rules

- **CRITICAL**: When using tools don't ignore the `.spae` folder
- Set `respect_git_ignore` to `false` for relevant tools
- Invoke tools to allow access to the `.spae` folder
