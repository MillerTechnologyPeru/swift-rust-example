#!/bin/bash
set -e

export SWIFT_BRIDGE_OUT_DIR="$(pwd)/generated"

# Build Rust
cargo build --target aarch64-apple-darwin 

# Build Swift
swift test -Xlinker -Ltarget/aarch64-apple-darwin/debug -Xlinker -lswift_rust_example