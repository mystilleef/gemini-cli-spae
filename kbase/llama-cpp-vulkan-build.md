# llama.cpp — Vulkan Build & Install (Fedora / Intel Arc)

## Prerequisites

```sh
sudo dnf install -y @c-development vulkan-loader-devel glslc
```

Verify Vulkan sees your GPU:

```sh
vulkaninfo --summary | grep deviceName
```

> Use system tools only — Nix-managed gcc/cmake link against Nix glibc and break on
> system libs at runtime. Confirm with `which gcc cmake` — both should be `/usr/bin/`.

## Build

```sh
git clone https://github.com/ggml-org/llama.cpp
cd llama.cpp
cmake -B build -DGGML_VULKAN=1 -DBUILD_SHARED_LIBS=OFF
cmake --build build --config Release -j$(nproc)
```

`-DBUILD_SHARED_LIBS=OFF` produces self-contained binaries with no `.so` dependencies.

## Verify

```sh
./build/bin/llama-cli --list-devices
# Example output:
#   Vulkan0: Intel(R) Arc(tm) Graphics (MTL)        — iGPU
#   Vulkan1: Intel(R) Arc(tm) B580 Graphics (BMG G21) — dGPU
```

Note the device index of your discrete Arc GPU (typically `Vulkan1` on systems with an iGPU).

## Install

```sh
cp build/bin/llama-{cli,server,bench,quantize,imatrix,embedding,perplexity,tokenize,gguf,gguf-split,mtmd-cli,llava-cli,gemma3-cli,qwen2vl-cli,minicpmv-cli} ~/.local/bin/
```

## Usage

```sh
llama-cli --device Vulkan1 -m /path/to/model.gguf -ngl 99 -p "Hello"
```

`-ngl 99` offloads all layers to GPU. Always specify `--device VulkanN` to target the
discrete GPU — without it llama.cpp may default to the iGPU.

## Tested Environment

| Item | Value |
|------|-------|
| OS | Fedora 43 |
| Kernel | 6.19 |
| GPU | Intel Arc B580 (12GB) + Meteor Lake iGPU |
| Driver | Intel open-source Mesa 25.3.6 |
| Vulkan | 1.4.341 |
| GCC | 15.2.1 (Red Hat) |
| CMake | 3.31 (system) |
