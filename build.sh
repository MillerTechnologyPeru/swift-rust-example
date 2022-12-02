#!/bin/bash
set -e
export SWIFT_BRIDGE_OUT_DIR="$(pwd)/generated"

# Fetch Rust dependencies
cargo fetch

# Copy Rust dependencies
mkdir -p .build/plugins/outputs/swift-rust-example/SwiftRustExample/RustPlugin/cargo-build/
cp -rf ~/.cargo/*  .build/plugins/outputs/swift-rust-example/SwiftRustExample/RustPlugin/cargo-build/

# Build Swift
swift build --build-tests
