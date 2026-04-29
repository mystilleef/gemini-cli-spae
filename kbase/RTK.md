# Rust token killer

**Usage**: token-optimized CLI proxy for shell commands.

## Rule

Always prefix shell commands with `rtk`.

Examples:

```bash
rtk git status
rtk cargo test
rtk npm run build
rtk pytest -q
```

## Meta commands

```bash
rtk gain            # Token savings analytics
rtk gain --history  # Recent command savings history
rtk discover          # Analyze Claude Code history for missed opportunities
rtk proxy <cmd>     # Run raw command without filtering
```

## Verification

```bash
rtk --version
rtk gain
which rtk
```
