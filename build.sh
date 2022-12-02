#!/bin/bash
set -e

export SWIFT_BRIDGE_OUT_DIR="$(pwd)/generated"

# Build Rust
cargo build

# Copy registry
cp -rf ~/.cargo/*  .build/plugins/outputs/swift-rust-example/SwiftRustExample/RustPlugin/cargo-build/

# Build Swift
swift test