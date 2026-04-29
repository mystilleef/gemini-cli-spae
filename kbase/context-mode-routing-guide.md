# Context-Mode Routing Guide (Agent/Token/Context Optimized)

**Non-optional:** Follow these routing rules to avoid context flooding.

## Core Rule: Think in Code

For any **analyze/count/filter/parse/compare/search/transform/summarize** task, use:

- `mcp__context-mode__ctx_execute(language, code)`

Print only the final answer with `console.log()`.  
Use robust JavaScript (Node/Bun compatible), built-ins only (`fs`, `path`, `child_process`), with `try/catch` and null/undefined guards.

> Do not pull large raw data into chat for manual reasoning.

---

## Blocked Paths (Do Not Attempt)

### Shell-blocked patterns
- `curl`, `wget`
- inline HTTP patterns in shell (`fetch('http`, `requests.get/post`, `http.get/request`)
- direct web browsing fetches

### Required replacements
- Web content: `ctx_fetch_and_index(url, source)` → `ctx_search([...])`
- HTTP/programmatic fetch: `ctx_execute("javascript", code)`

---

## Redirect Rules

### Shell with non-trivial output
Use direct shell only for short-output commands (e.g., `git`, `ls`, `mkdir`, `rm`, `mv`, `cd`, `npm install`, `pip install`).

Otherwise use:
- `ctx_batch_execute(commands, queries)` (preferred), or
- `ctx_execute("shell", code)`

### File reading
- **Editing a file:** normal file read is appropriate.
- **Analyzing/summarizing/exploring:** use `ctx_execute_file(path, language, code)`.

### Search/grep
Run in sandbox (`ctx_execute("shell", "...")`) and print concise summaries only.

---

## Tool Selection Hierarchy (Default Order)

1. **GATHER:** `ctx_batch_execute(commands, queries)`  
   Bundle all collection commands + questions in one call.
2. **FOLLOW-UP:** `ctx_search([q1, q2, ...])`  
   Ask all follow-up queries in a single array.
3. **PROCESS:** `ctx_execute(...)` or `ctx_execute_file(...)`
4. **WEB:** `ctx_fetch_and_index(...)` then `ctx_search(...)`
5. **INDEX:** `ctx_index(content, source)`

---

## Output Constraints

- Keep assistant responses under **500 words**.
- Write large artifacts (code/config/PRD/docs) to files.
- In chat, return only:
  - `file path`
  - one-line description
- Use descriptive `source` labels when indexing for reliable future retrieval.

---

## `ctx` Command Mappings

- `ctx stats`  
  Call `stats`; print full output verbatim.
- `ctx doctor`  
  Call `doctor`; run returned shell command; present checklist.
- `ctx upgrade`  
  Call `upgrade`; run returned shell command; present checklist.
- `ctx purge`  
  Warn user, then call `purge(confirm: true)`.

After `/clear` or `/compact`, stats and KB persist. Use `ctx purge` for a full reset.
