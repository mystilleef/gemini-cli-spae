---
name: skill-creator
description:
  "Creates a new agent skill optimized for token and context efficiency."
user-invocable: true
argument-hint: "<skill name> and <description or instructions>"
---

# Skill creator

## When to use

- Creating a new skill for the agent.
- Scaffolding the standard directory structure for a skill.

## Process

1. Resolve the target path. Default to `~/.agents/skills/<name>/` unless
   the user requests a local or project-level path
   (`./.agents/skills/<name>/`).
2. Verify `<name>` uses `kebab-case` (lowercase letters, digits,
   hyphens).
3. Halt if the target directory already exists.
4. Create the target directory and standard subdirectories: `scripts/`,
   `references/`, `assets/`, and `tests/`.
5. Read `references/skill-reference-guide.md` (relative to this skill)
   for templating rules.
6. Generate `SKILL.md` in the target directory based on the user's
   instructions and the reference guide.
7. Optimize the generated `SKILL.md` for agent, token, and context
   efficiency. Use concise language, cut redundant instructions, and
   structure the document for fast scanning.

## Verification

- The target directory and all standard subdirectories exist.
- `SKILL.md` exists in the target directory.
- The generated `SKILL.md` adheres to the blueprint format (Process,
  Verification, Rules).
- The generated `SKILL.md` explicitly instructs the agent to optimize
  for token and context efficiency.

## Rules

- Execute directory and file creation in a single pass.
- Read only the least required reference material.
- Ensure the generated skill enforces token and context efficiency
  without sacrificing clarity or proper formatting.
- Emit compact, path-based output upon completion (for example,
  `SUCCESS: Created skill <name> at <path>`).
