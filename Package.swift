// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRustExample",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftRustExample",
            targets: ["SwiftRustExample"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.2.0"
        )
    ],
    targets: [
        .target(
            name: "SwiftRustExample",
            dependencies: [
                "CSwiftRust"
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-Xlinker", "-lswift_rust_example",
                ])
            ],
            plugins: [
                "RustPlugin"
            ]
        ),
        .target(
            name: "CSwiftRust",
            swiftSettings: [
                .unsafeFlags([
                    "-Xlinker", "-lswift_rust_example",
                ])
            ],
            plugins: [
                "RustPlugin"
            ]
        ),
        .plugin(
            name: "RustPlugin",
            capability: .buildTool(),
            dependencies: [
                "SwiftRustTool"
            ]
        ),
        .executableTarget(
            name: "SwiftRustTool",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                )
            ]
        ),
        .testTarget(
            name: "SwiftRustExampleTests",
            dependencies: ["SwiftRustExample"],
            swiftSettings: [
                .unsafeFlags([
                    "-Xlinker", "-lswift_rust_example",
                ])
            ]
        )
    ]
)
