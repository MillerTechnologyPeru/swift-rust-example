//
//  Cargo.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation

/// Cargo command
enum Cargo {
    
    /// `cargo-clean` - Remove generated artifacts
    case clean(Clean)

    /// `cargo-build` - Compile the current package
    case build(Build)
}

extension Cargo: CustomStringConvertible {
    
    public var description: String {
        command
    }
}

extension Cargo {
    
    var arguments: [String] {
        var arguments = [String]()
        arguments.reserveCapacity(5)
        switch self {
        case let .build(build):
            build.appendArguments(&arguments)
        case let .clean(clean):
            clean.appendArguments(&arguments)
        }
        return arguments
    }
    
    var command: String {
        return arguments.reduce("cargo", { $0 + " " + $1 })
    }
}

extension Cargo {
    
    enum Command {
        
        /// `cargo-clean` - Remove generated artifacts
        ///
        /// [Documentation](https://doc.rust-lang.org/cargo/commands/cargo-clean.html)
        case clean
        
        /// `cargo build` command
        ///
        /// [Documentation](https://doc.rust-lang.org/cargo/commands/cargo-build.html)
        case build
    }
}

extension Cargo {
    
    /// `cargo-clean` - Remove generated artifacts
    ///
    /// [Documentation](https://doc.rust-lang.org/cargo/commands/cargo-clean.html)
    struct Clean: Equatable, Hashable, CargoCommand {
        
        static var command: String { "clean" }
        
        /*
         --manifest-path path
         Path to the Cargo.toml file. By default, Cargo searches for the Cargo.toml file in the current directory or any parent directory.
         */
        let manifestPath: String
        
        /*
         When no packages are selected, all packages and all dependencies in the workspace are cleaned.

         -p spec...
         --package spec...
         Clean only the specified packages. This flag may be specified multiple times. See cargo-pkgid(1) for the SPEC format.
         */
        let package: String?
        
        /*
         --target-dir directory
         Directory for all generated artifacts and intermediate files. May also be specified with the CARGO_TARGET_DIR environment variable, or the build.target-dir config value. Defaults to target in the root of the workspace.
         */
        let targetDirectory: String
        
        var arguments: [Argument] {
            var arguments = [Argument]()
            arguments.reserveCapacity(3)
            arguments.append(.manifestPath(manifestPath))
            if let value = package {
                arguments.append(.package(value))
            }
            arguments.append(.targetDirectory(targetDirectory))
            return arguments
        }
    }
    
    /// `cargo-build` - Compile the current package
    struct Build: Equatable, Hashable, CargoCommand {
        
        static var command: String { "build" }
        
        /*
         --manifest-path path
         Path to the Cargo.toml file. By default, Cargo searches for the Cargo.toml file in the current directory or any parent directory.
         */
        let manifestPath: String
        
        /*
         By default, when no package selection options are given, the packages selected depend on the selected manifest file (based on the current working directory if --manifest-path is not given). If the manifest is the root of a workspace then the workspaces default members are selected, otherwise only the package defined by the manifest will be selected.

         The default members of a workspace can be set explicitly with the workspace.default-members key in the root manifest. If this is not set, a virtual workspace will include all workspace members (equivalent to passing --workspace), and a non-virtual workspace will include only the root crate itself.

         -p spec...
         --package spec...
         Build only the specified packages. See cargo-pkgid(1) for the SPEC format. This flag may be specified multiple times and supports common Unix glob patterns like *, ? and []. However, to avoid your shell accidentally expanding glob patterns before Cargo handles them, you must use single quotes or double quotes around each pattern.
         */
        let package: String?
        
        /*
         --target-dir directory
         Directory for all generated artifacts and intermediate files. May also be specified with the CARGO_TARGET_DIR environment variable, or the build.target-dir config value. Defaults to target in the root of the workspace.
         */
        let targetDirectory: String
        
        /*
         --target triple
         Build for the given architecture. The default is the host architecture. The general format of the triple is <arch><sub>-<vendor>-<sys>-<abi>. Run rustc --print target-list for a list of supported targets. This flag may be specified multiple times.
         This may also be specified with the build.target config value.

         Note that specifying this flag makes Cargo run in a different mode where the target artifacts are placed in a separate directory. See the build cache documentation for more details.
         */
        let targetArchitecture: String?
        
        /*
         -r
         --release
         Build optimized artifacts with the release profile. See also the --profile option for choosing a specific profile by name.
         */
        let releaseConfiguration: Bool
        
        var arguments: [Argument] {
            var arguments = [Argument]()
            arguments.reserveCapacity(5)
            arguments.append(.manifestPath(manifestPath))
            if let value = package {
                arguments.append(.package(value))
            }
            arguments.append(.targetDirectory(targetDirectory))
            if let value = targetArchitecture {
                arguments.append(.targetArchitecture(value))
            }
            if releaseConfiguration {
                arguments.append(.releaseConfiguration)
            }
            return arguments
        }
    }
}

extension Cargo {
    
    static var executablePath: String {
        #if os(macOS)
        return "/opt/homebrew/bin"
        #else
        return "/usr/bin"
        #endif
    }
}

extension Cargo {
    
    /// `cargo` arguments and options
    enum Argument {
        
        /// `--manifest-path path`
        case manifestPath(String)
        
        /// `--package name`
        case package(String)
        
        /// `--target-dir directory`
        case targetDirectory(String)
        
        /// `--target triple`
        case targetArchitecture(String)
        
        /// `--release`
        case releaseConfiguration
        
        var arguments: [String] {
            switch self {
            case let .manifestPath(value):
                return ["--manifest-path", value]
            case let .package(value):
                return ["--package", value]
            case let .targetDirectory(value):
                return ["--target-dir", value]
            case let .targetArchitecture(value):
                return ["--target", value]
            case .releaseConfiguration:
                return ["--release"]
            }
        }
    }
}

protocol CargoCommand {
    
    static var command: String { get }
    
    var arguments: [Cargo.Argument] { get }
}

extension CargoCommand {
    
    func appendArguments(_ arguments: inout [String]) {
        arguments.append(Self.command)
        self.arguments.forEach {
            arguments += $0.arguments
        }
    }
}
