#!/bin/sh

# --- Context Orchestrator ---
# Injects the core safety baseline into the agent's context.
# Dependencies: jq (recommended)

set -euf

# 1. Read input from stdin to maintain compatibility with hook architecture
# and prevent broken pipe errors from the CLI.
# shellcheck disable=SC2034
input=$(cat)

# 2. Define Core Safety Baseline
CORE_BASELINE='
- COMMITS: No autonomous commits.
- Optimize all operations for agent, token, and context efficiency.
- Batch and parallelize as much as possible.
- ALWAYS prefix ALL shell commands with rtk.
- Use context mode tools for token and context optimizations.
- Forbid copular verb forms.
- Keep prose brief, concise, precise while maintaining clarity.
- Optimize prose for token and context efficiency.
- Use elegant, well-structured, idiomatic markdown.
'
readonly CORE_BASELINE

# 3. Main Execution Logic
main() (
  if command -v jq > /dev/null 2>&1; then
    # jq safely constructs and guarantees valid JSON output
    jq -n \
      --arg context "${CORE_BASELINE}" \
    '{
      decision: "allow",
      hookSpecificOutput: {
        hookEventName: "BeforeAgent",
        additionalContext: $context
      }
    }'
  else
    # Fallback for environments without jq
    # Escape backslashes, double quotes, and newlines for JSON
    _esc_context=$(printf '%s' "${CORE_BASELINE}" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/' | tr -d '\n')
    # Remove the trailing \n added by sed for the last line
    _esc_context="${_esc_context%\\n}"

    printf '{\n  "decision": "allow",\n  "hookSpecificOutput": {\n    "hookEventName": "BeforeAgent",\n    "additionalContext": "%s"\n  }\n}\n' "${_esc_context}"
  fi
)

main
