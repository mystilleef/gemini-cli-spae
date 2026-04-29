---
name: refactor
description: Refactor code to simplify it while preserving behavior.
kind: local
model: auto-gemini-3
temperature: 0.4
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

- Invoke the `refactor` skill.
