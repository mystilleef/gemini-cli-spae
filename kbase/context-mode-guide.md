# Context-mode guidelines

Mandatory routing rules protect context window. Keep raw data in
sandbox.

## Think in code—mandatory

Analyze, count, filter, compare, search, parse, or transform data by
**writing code** via `ctx_execute(language, code)`.

- `console.log()` only the answer.
- Don't read raw data into context.
- PROGRAM the analysis; don't compute in reasoning.
- Handle `null`/`undefined` with `try/catch`.

## Tool selection hierarchy

0. **MEMORY**: _`ctx_search(sort: "timeline")`_. Search prior context
   before asking user.
1. **GATHER**: _`ctx_batch_execute(commands, queries)`_. One call
   replaces many. Use descriptive labels.
2. **FOLLOW-UP**: _`ctx_search(queries: [...])`_. Batch all questions in
   one call.
3. **PROCESSING**: _`ctx_execute(language, code)`_ |
   _`ctx_execute_file(path, language, code)`_. Sandbox only; `stdout`
   enters context.
4. **WEB**: _`ctx_fetch_and_index(url, source)`_ then
   _`ctx_search(queries)`_. Raw HTML never enters context.
5. **INDEX**: _`ctx_index(content, source)`_. Store in FTS5 for later
   search.

## Routing rules

### Blocked—don't attempt

- **curl / wget**: Intercepted and blocked in shell. Use
  `ctx_fetch_and_index` or `ctx_execute` with `fetch`.
- **Inline HTTP**: The system blocks `fetch('http`, `requests.get(`,
  etc. in shell scripts.
- **Direct web fetching**: Use `ctx_fetch_and_index`.

### Redirected—use sandbox

- **Shell (>20 lines output)**: Use `ctx_batch_execute` or
  `ctx_execute`.
- **Bash ONLY for**: `git`, `mkdir`, `rm`, `mv`, `cd`, `ls`,
  `npm install`, `pip install`.
- **Read (for analysis)**: Use `ctx_execute_file`. `read_file` serves
  only for editing.
- **Grep (large results)**: Use
  `ctx_execute(language: "shell", code: "grep ...")`.

## Parallel I/O batches

Use `concurrency: 4-8` for I/O-bound work (network, API, multi-repo
git).

- GitHub API: Cap at `concurrency: 4`.
- CPU-bound (test, build, lint): Keep `concurrency: 1`.

## Output style

Terse like caveman. Technical substance exact. Only fluff die.

- Drop articles, filler, pleasantries, hedging.
- Fragments OK. Short synonyms.
- Pattern: `[thing] [action] [reason]. [next step].`
- **Artifacts**: Write to files. Return:
  `file path + 1-line description`.

## Session & memory

- **Continuity**: Skills, roles, and decisions persist.
- **Memory**: Search `source: "decision"`, `source: "constraint"`, or
  `source: "compaction"` before asking `what were we working on?`.

## Context mode commands

| Command       | Action                                  |
| ------------- | --------------------------------------- |
| `ctx stats`   | Verbatim output of `ctx_stats`.         |
| `ctx doctor`  | Run `ctx_doctor` and follow checklist.  |
| `ctx upgrade` | Run `ctx_upgrade` and follow checklist. |
| `ctx purge`   | Irreversible wipe of knowledge base.    |
