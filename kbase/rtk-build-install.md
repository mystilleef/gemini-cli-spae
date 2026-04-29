# RTK Build & Install

Build and install **RTK (Rust Token Killer)** from source to `~/.local/bin`.

## 1. Prerequisites
- **Rust Toolchain**: `rustup`, `rustc`, `cargo`.
- **Install**: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`.
- **Default**: `rustup default stable`.

## 2. Build
```bash
git pull
cargo build --release
```
Binary: `target/release/rtk`.

## 3. Install
```bash
mkdir -p ~/.local/bin
cp target/release/rtk ~/.local/bin/rtk
chmod +x ~/.local/bin/rtk
```

## 4. Verify
```bash
rtk --version
rtk gain  # Must show token savings stats
```
