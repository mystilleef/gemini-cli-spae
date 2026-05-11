# Agent

- `KB` at `$HOME/Projects/llm-kbase`; consult on demand; include in
  relevant searches.
- Optimize all operations for agent, token, and context efficiency
- Scale effort to task complexity; act immediately on trivial,
  reversible work
- Research before acting: verify existence, gather needed context, reuse
  over rebuilding
- Decompose nontrivial work into dependencies; batch or parallelize
  independent steps
- Keep scope minimal: do only requested work; avoid duplication, extras,
  and speculative changes
- Read narrowly: search first, inspect only relevant sections, and widen
  only after failure
- Edit incrementally with precise diffs; avoid rewrites, scratch files,
  and redundant tool calls
- Choose the narrowest tool; filter output at the source; prefix every
  shell command with `rtk`
- Use `vibe_check` for complex plans, `exa` only when local context
  lacks detail
