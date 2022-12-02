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
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftRustExample",
            dependencies: [
                "CSwiftRust"
            ],
            swiftSettings: [
                .unsafeFlags([
                    //"-Xlinker", "-lswift_rust_example",
                ])
            ],
            plugins: [
                "RustPlugin"
            ]
        ),
        .target(
            name: "CSwiftRust",
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
            dependencies: ["SwiftRustExample"]
        )
    ]
)
