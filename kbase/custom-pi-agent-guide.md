# Custom pi agent reference guide

This guide provides the essential specifications for creating custom pi
`subagents`. Markdown files with YAML `frontmatter` define agents.

## 1. File locations & priority

Save custom agent files as `{name}.md` in one of the following
locations:

<!-- prettier-ignore -->
| Scope | Path | Priority |
| --- | --- | --- |
| Project | `.pi/agents/{name}.md` | Highest; overrides user and builtin |
| User | `~/.pi/agent/agents/{name}.md` | Medium; overrides builtin |

_Note: project discovery also reads legacy `.agents/{name}.md` files,
but prefer `.pi/agents/`._

## 2. Agent structure

An agent file contains YAML `frontmatter` followed by the system prompt
in Markdown.

```yaml
---
name: my-custom-agent
description: A concise description of the agent's purpose
tools: read, bash, mcp:chrome-devtools # Builtin + optional MCP tools
extensions: /path/to/ext.ts # Extension allowlist (absent=all, empty=none)
model: claude-haiku-4-5 # Primary model
fallbackModels: openai/gpt-5-mini # Comma-separated backup models
thinking: high # off, minimal, low, medium, high, xhigh
systemPromptMode: replace # replace (default) or append
inheritProjectContext: false # false (default) or true
inheritSkills: false # false (default) or true
skill: safe-bash # Comma-separated specific skills to inject
output: result.md # Default output file
defaultReads: context.md # Comma-separated default files to read
defaultProgress: true # Enable progress.md tracking
maxSubagentDepth: 1 # Tighten nested delegation limit
---
Your system prompt goes here. This markdown body defines the agent's
behavior and instructions.
```

## 3. Prompt assembly philosophy & inheritance

Custom `subagents` support **narrow and intentional** work. By default,
they run fully isolated and see only explicit input.

- **`systemPromptMode`**:
  - `replace` (Default): The agent's markdown body becomes the entire
    system prompt. Clean slate.
  - `append`: Pi appends the agent's prompt to its normal base prompt.
- **`inheritProjectContext`**:
  - `false` (Default): Strips inherited project-level instructions (for
    example, `AGENTS.md`, `CLAUDE.md`).
  - `true`: Keeps project-level instructions. Use for agents that must
    follow `repo` conventions.
- **`inheritSkills`**:
  - `false` (Default): Strips Pi's discovered skills catalog.
  - `true`: Child sees the full skills list.

## 4. Common configuration recipes

<!-- prettier-ignore -->
| Goal | Prompt | Project context | Skills |
| --- | --- | --- | --- |
| **Fully isolated specialist** (default) | `replace` | `false` | `false` |
| **Project-aware specialist** | `replace` | `true` | `false` |
| **Generic helper** (Pi-plus) | `append` | `true` | `true` |

## 5. Tool & extension semantics

- **`tools` omitted**: Agent gets Pi's normal default builtin tools.
- **`tools` present**: Acts as an explicit `allowlist` for builtin
  tools.
- **`mcp:server/tool`**: Additive direct MCP tools (requires
  `pi-mcp-adapter`). Leaves builtin tool resolution unchanged.
- **`extensions` omitted**: All extensions load.
- **`extensions:` (empty)**: No extensions load (`--no-extensions`).
