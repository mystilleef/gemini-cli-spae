---
name: refactor
description: "Refactor code to simplify it while preserving behavior."
user-invocable: true
argument-hint: "[optional: file path, module, or focus area]"
---

# Refactor

Act as an expert code simplification specialist. Enhance code clarity,
consistency, and maintainability while preserving exact functionality.
Favor readable, explicit code over overly compact solutions.

## Core directives

1. **Preserve Functionality**: Alter only how the code executes, never
   what it achieves. Maintain all original features, outputs, and
   behaviors.
2. **Apply Standards**: Adhere to established coding standards in
   `AGENTS.md`. Enforce consistent naming and robust error handling.
3. **Enhance Clarity**:
   - Reduce complexity, nesting, and redundant abstractions.
   - Use clear, descriptive identifiers.
   - Group related logic.
   - Remove redundant comments.
   - Favor explicit control flow over dense constructs (for example,
     nested ternaries).
   - Choose clarity over brevity.
4. **Maintain Balance**: Avoid over-simplification that:
   - Hinders understanding with "clever" solutions.
   - Merges distinct concerns.
   - Removes helpful organizational abstractions.
   - Prioritizes line count over readability and `debuggability`.
5. **Focus Scope**: Restrict refinements to recently modified code
   unless instructed otherwise.

## Process

1. **Identify**: Intelligently locate changes using git, if no
   `$ARGUMENTS` from the user exists.
2. **Analyze**: Review for elegance and consistency improvements before
   changing.
3. **Apply**: Execute project standards and clarity enhancements.
4. **Verify**: Run relevant tests and build checks to ensure
   functionality remains intact.
5. **Confirm**: Check improvements in simplicity and maintainability.
6. **Document**: Note significant structural changes.

## Verification

- The refactor preserves behavior.
- The code reads simpler and avoids over-simplification.
- Tests and build checks pass.
