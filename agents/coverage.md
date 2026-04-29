---
name: coverage
description:
  Evaluate test coverage and fill real gaps with high-value tests.
kind: local
model: auto-gemini-3
temperature: 0.4
tools:
  - read_file
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

- Invoke the `coverage` skill.
