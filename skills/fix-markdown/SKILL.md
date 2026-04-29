---
name: fix-markdown
description:
  Fix lint, formatting, and prose issues in markdown files using
  Prettier and Vale. Use when the user or agent needs to fix lint,
  formatting, and prose issues in markdown files.
---

# Agent protocol: Fix markdown file

**`GOAL`**: use prettier and vale to fix lint, formatting, and prose
issues in markdown files.

**`WHEN`**: use when the user or agent needs to fix lint, formatting, or
improve prose in markdown files.

**`NOTE`**: strictly follow E-Prime directive (avoid "`to be`" verbs)
when writing or correcting prose.

## References

The following reference files provide strict guidelines when updating
prose.

Locate the reference files in the `references` folder.

- **`references/e-prime-directive.md`**: _The E-Prime Communication
  Protocol defining the rules for avoiding non-E-Prime verb forms._
- **`references/table-optimization.md`**: _Guidelines for maintaining
  Markdown tables within an 80-character line limit._

## Primary directives

### Formatting and linting sequence

- **Format first & last**: Always run prettier before analysis and after
  edits
- **E-Prime compliance**: Strictly follow
  `references/e-prime-directive.md` when writing/correcting prose
- **Vale cycle**: Run vale iteratively (lint → fix → verify) until no
  issues remain
- **Research complex issues**: Use search tools or Perplexity for
  unfamiliar lint problems

### Table width management

- **80-Character Compliance**: Maintain all Markdown table rows within
  an 80-character limit.
- **Preservation Hierarchy**: Prefer table preservation through
  reformatting (Reference Links, Header Compression, Vertical Stacking)
  before structural conversion.
- **Optimization Priority**: Apply techniques from
  `references/table-optimization.md` to ensure compliance while
  maintaining readability.
- **Prettier Integration**: Use `<!-- prettier-ignore -->` to protect
  manually optimized tables from automatic reformatting.

### Tool commands

- Format: `prettier --write <file_path>`
- Sync rules: `vale sync`
- Lint: `vale --no-wrap --output=JSON <file_path>`

### Vale fixing guidelines

- **Path wrapping**: Wrap filenames, `URIs`, `URLs`, and paths in
  backticks
- **Context awareness**: Check line numbers - issues may appear as
  `substrings` in technical terms
- **False positives**: Wrap acronyms, names, and proper nouns in
  backticks, or square brackets if backticks don't work
- **Headings**: Use sentence case (capitalize first character only)
- **Passive voice**: Follow E-Prime directive to remove "`to be`" verbs
- **Follow hints**: Use Vale's issue links when needed

## Efficiency directives

- Optimize all operations for token and context efficiency
- Batch operations on file groups, avoid individual file processing
- Use parallel execution when possible
- Target only requested files
- Reduce token usage in all operations

## Workflow

- Run `vale sync` to update lint rules
- Run `prettier --write` for baseline formatting
- Study file and apply Vale path directives (wrap all paths/filenames in
  backticks)
- **Audit table widths**: Identify Markdown tables exceeding 80
  characters. Apply optimization techniques from
  `references/table-optimization.md` to ensure compliance.
- Iteratively run `vale`, fix issues, and verify until no issues remain
- Run `prettier --write` for final formatting
- **`DONE`**

## Output

**Files modified:**

- Target markdown files - Formatted and lint-free

**Status communication:**

- Reports number of issues fixed
- Confirms Vale shows zero remaining issues
- Lists file paths processed
