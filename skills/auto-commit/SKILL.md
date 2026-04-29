---
name: auto-commit
description:
  Autonomously group, stage, and commit all changes in a repository into
  atomic commits.
user-invocable: true
argument-hint: ""
---

# Goal

Autonomously group, stage, and commit all changes in a repository into
atomic commits for the current project.

## When to use

- When the agent needs to autonomously commit all changes in a
  repository using atomic commits.

## Process

1. **Analyze Status**: Execute `git status --porcelain=v2 --branch` to
   identify all changes.
2. **Identify Atomic Groups**: Use heuristics from
   `references/atomic-git-staging.md` to group files into logical
   changes. Isolate `.gitignore` changes into their own commit.
   - **Shortcut**: If exactly one tracked `unstaged` file exists, stage
     and commit it immediately.
3. **Loop through Groups**:
   1. **Analyze Group**: Use
      `git --no-pager diff --no-ext-diff --stat --minimal --patience --histogram --find-renames --summary --no-color -U10 <file_group>`
      to understand the changes.
   2. **Stage**: Execute `git add <file1> <file2> ...`.
   3. **Message**: Generate a conventional commit message based on
      `references/conventional-commit.md`.
   4. **Commit**: Execute `git commit -m "<message>"`.
   5. **Verify**: Verify the commit succeeded. If `ERROR`, halt and
      report.
4. **Repeat**: Continue until achieving a clean working tree.
5. **Final Status**: Output a concise summary of the commits created
   (for example, a list of commit hashes and subjects) to confirm
   successful execution.

## Verification

- The working tree remains clean.
- Separate, atomic commits group all logical changes.
- Commit messages follow the conventional commit format.
- The commit excludes sensitive or build-related files.

## Rules

- **Git Commands**: Use `--no-pager` and `--no-ext-diff` for all diff
  operations.
- **Atomic Grouping**: Group files that _must_ exist together (for
  example, implementation + test).
- **No User Input**: Autonomously perform commits without awaiting user
  approval for messages.
- **Current Project**: Only commit changes in the current project.
- **Self-Contained**: Don't depend on or invoke any other skills.
  Perform git commands directly.
- **Efficiency**:
  - Optimize all operations for agent, token, and context efficiency.
  - Batch operations on file groups; avoid individual file processing.
  - Use parallel execution when possible.
  - Target only relevant files.
  - Reduce token usage.
- **Safety**: Intelligently handle `untracked` files and avoid staging
  sensitive or build-related files (refer to `atomic-git-staging.md`).
