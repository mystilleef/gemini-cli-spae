---
name: shell-script-maker
description:
  Create or modify portable, POSIX-compliant shell scripts following
  best practices for robustness and style. Use when the user or agent
  needs to create a new shell script, or modify an existing one.
---

# Shell script maker

**`GOAL`**: Create or modify shell scripts that adhere to `POSIX`
standards, ensure robustness, and follow established style guidelines.

**`WHEN`**: You, or the user, need to generate a new shell script or
update an existing one.

**`NOTE`**: Prioritize portability and safety over shell-specific
features (`bashisms`) unless explicitly required.

## Efficiency directives

- Optimize all operations for agent, token, and context efficiency
- Batch operations on file groups, avoid individual file processing
- Use parallel execution when possible
- Target only relevant files
- Reduce token usage

## Task management

- Use the native task management system to track and manage your work,
  workflow, and tasks.

## References

- `references/shell-scripting-guide.md`: The foundation for structuring
  scripts, emphasizing portability and best practices.
- `assets/template.sh`: A template for creating new scripts.

## Workflow

Follow these steps to author a script:

### Step 1: Initialization and prerequisites

- Make a plan using the native task management system.
- **New script**: Choose a sensible, logical, and descriptive name
  (kebab-case). Use `assets/template.sh` as the foundation.
- **Existing script**: Analyze the current structure, identify required
  changes, and ensure it aligns with
  `references/shell-scripting-guide.md`.
- Define the script's purpose, required arguments, and dependencies.
- Check for necessary dependencies using `command -v`.

### Step 2: Script construction

- Adhere to the standards in `references/shell-scripting-guide.md` for
  portability, robustness, style, and I/O.
- Include a standardized header with description, dependencies, and
  usage.
- Provide a `-h/--help` flag for usage instructions.
- Perform strict input validation and `sanitization` for all arguments.

### Step 3: Hardening and formatting

- Apply `shellharden --replace` for security hardening.
- Apply `shfmt -p -i 2 -ci -sr -w` for `POSIX`-compliant formatting.
- Apply `beautysh --indent-size 2 --variable-style braces` to restore
  braces.

### Step 4: Linting and fixing

- Run `shellcheck -s sh -o all` for `POSIX` compliance.
- Fix **ALL** issues `shellcheck` finds.

### Step 5: Verifying and testing

Check script functionality and safety through automated testing.

- **Test Development**: Create `tests/test-<script-name>.sh` targeting
  core logic, edge cases, and error states.
- **Validation**:
  - Apply `chmod +x` to the script and test suite.
  - Execute tests and verify a 100% success rate.
  - Verify `-h/--help` output and dry-run safety for destructive
    operations.

### Step 6: Refactoring and refinement

Optimize script structure and logic for readability and performance.

- **Structural Optimization**:
  - Flatten logic by using early `return` or `exit` to reduce nesting.
  - Use `case` statements instead of complex `if/elif` chains.
  - Extract repeated logic into single-responsibility functions.
- **Technical Alignment**:
  - Audit script against `references/shell-scripting-guide.md` for
    naming, quoting, scope, and `POSIX` efficiency.
  - Ensure structural changes preserve `trap` logic and resource
    cleanup.
- **Regression Testing**: Re-run the automated test suite to verify 100%
  coverage and functional integrity.

### Step 7: Final review

Perform a final quality check before completion.

- **Error Handling**: Confirm the script returns explicit non-zero exit
  codes for all failure modes.
- **Documentation**: Ensure the header and help message accurately
  reflect the final script behavior.
- **DONE**

## Output

**Files created/modified:**

- `<script-name>.sh` - The authored, executable shell script.
- `tests/test-<script-name>.sh` - Automated tests for the script.

**Status communication:**

- `STATUS: SUCCESS` upon successful script creation and verification.
- `STATUS: ERROR` if verification fails or dependencies missing.
