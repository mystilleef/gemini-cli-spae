# Build & Install pi-mono

## Prerequisites

- **Node.js** `>=20.0.0`
- **Git**
- **npm**

## Build Workflow

```bash
# 1. Update repository
git pull

# 2. Install dependencies
npm install

# 3. Fix native dependency issues (Linux glibc)
npm install @tailwindcss/oxide-linux-x64-gnu @parcel/watcher-linux-x64-glibc

# 4. Build all packages
npm run build

# 5. Link CLI globally
cd packages/coding-agent && npm link
```

## Notes

- Build order matters: `tui` → `ai` → `agent` → `coding-agent` must build first
- `npm link` creates a global `pi` command pointing to `packages/coding-agent/dist/cli.js`
- Native bindings are required on Linux glibc systems for `tailwindcss` and `@parcel/watcher`
