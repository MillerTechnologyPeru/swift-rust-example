#!/bin/bash
set -e

export SWIFT_BRIDGE_OUT_DIR="$(pwd)/generated"

# Build Rust
cargo build

# Build Swift
swift test