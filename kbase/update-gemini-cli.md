# Update Gemini CLI guide

Update, build, and install `Gemini CLI` using
[`Volta`](https://volta.sh/) for isolated `Node.js` management.

## Prerequisites

- `Volta`
- `Git`

## Core workflow

Execute these commands from the project root to build and link the CLI
using `Node.js project_node_version`:

```bash
# 1. IMPORTANT! Always update repository
git pull

# 2. Clean and install dependencies
volta run --node project_node_version npm run clean && volta run --node project_node_version npm install

# 3. Build packages
volta run --node project_node_version npm run build

# 4. Link CLI globally
volta run --node project_node_version npm link

# 5. Verify
gemini --version
```

## Critical notes

- **Update repository**: _ALWAYS_ `git pull` to update the project.
- **Clean first**: `npm install` triggers a `prepare` hook. Always run
  `npm run clean` before `npm install` to avoid `EEXIST` errors in the
  `bundle/` directory.
- **Global linking**: `Volta` manages the binary link automatically. It
  associates the `gemini` command with the `Node.js` version active
  during `npm link`.
- **Path-based linking**: `Volta` doesn't support `npm link <path>`. Run
  `npm link` without arguments from the root.
