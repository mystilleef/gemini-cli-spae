---
name: optimize-markdown
description: Fix, refine, consolidate, and optimize markdown files.
user-invocable: true
argument-hint: "<markdown paths or scope>"
---

# Goal

Fix, refine, `consolidate`, condense, and optimize markdown files.

## When to use

- Markdown needs lint, prose, formatting, and efficiency improvements.
- Existing markdown content needs shorter, clearer agent-facing
  instructions.
- A repository or file group needs a repeatable markdown cleanup pass.

## Process

### 1. Target & baseline:

- Identify files from arguments or context.
- Execute `fix-markdown` to establish a clean state.
- If `fix-markdown` reports `WARN` and no further efficiency edits
  remain, report `WARN: no markdown changes needed` and exit.

### 2. Efficiency optimization:

For each file:

- Refine, `consolidate`, condense, and distill the document into its
  core essence.
- Organize information using elegant, well-structured, idiomatic
  markdown.
- Optimize prose and structure for token and context efficiency.
- Preserve clarity and intent.

### 3. Verification & reporting:

- Execute `fix-markdown` for final compliance.
- Report `SUCCESS: optimized markdown at <paths>` or `ERROR` on failure.

## Verification

- Target markdown files pass the `fix-markdown` workflow after edits.
- Content retains required meaning and formatting.
- Instructions favor concise, agent-readable structure.
- Output starts with `SUCCESS:`, `WARN:`, or `ERROR:`.

## Rules

- Optimize all operations for agent, token, and context efficiency.
- Batch operations on file groups; avoid one-file-at-a-time loops.
- Use parallel execution when possible.
- Target only relevant markdown files.
- Preserve user intent, code examples, links, and `frontmatter`.
- Never hide failures from sub-skills or `formatters`.
