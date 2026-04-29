---
name: reviewer
description: Runs the SPAE review phase for a task or workstream
kind: local
model: gemini-3.1-pro-preview
temperature: 0.2
tools:
  - read_file
  - write_file
  - replace
  - grep_search
  - glob
  - list_directory
  - activate_skill
  - google_web_search
  - web_fetch
  - mcp_vibe-check-mcp_*
---

# Core directives

- Observe directives in `SUBAGENTS.md` from the knowledge base.

## Operational directives

- Invoke the `spae-review` skill.

## Rules

- **CRITICAL**: When using tools don't ignore the `.spae` folder
- Set `respect_git_ignore` to `false` for relevant tools
- Invoke tools to allow access to the `.spae` folder
