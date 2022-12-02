//
//  BuildRust.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation
import PackagePlugin

@main
struct RustPlugin: BuildToolPlugin {
    
    let rustPackageName = "swift-rust-example"
    
    /// This entry point is called when operating on a Swift package.
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        
        let fileManager = FileManager.default
        
        // get paths
        let executable = try context.tool(named: "SwiftRustTool").path
        let packagePath = context.package.directory
        let manifestPath = packagePath.appending(subpath: "Cargo.toml")
        let rustDirectory = packagePath.appending(subpath: "src")
        let targetDirectory = context.pluginWorkDirectory.appending(subpath: "cargo-build")
        
        // create target directory
        print("Target directory:", targetDirectory.string)
        try? fileManager.createDirectory(atPath: targetDirectory.string, withIntermediateDirectories: true)
        
        // discover rust source files
        let rustFileURLs = try fileManager
            .contentsOfDirectory(at: URL(fileURLWithPath: rustDirectory.string), includingPropertiesForKeys: [], options: [.skipsHiddenFiles])
            .filter { $0.pathExtension == "rs" }
        
        // print found files
        print("Rust files:")
        rustFileURLs
            .lazy
            .map { $0.lastPathComponent }
            .forEach { print($0) }
        let rustFiles = rustFileURLs.map { Path($0.path) }
        
        // generate commands
        var commands = [Command]()
        
        // first compile rust code
        do {
            let cargoCommand = Cargo.build(
                Cargo.Build(
                    manifestPath: manifestPath.string,
                    package: rustPackageName,
                    targetDirectory: targetDirectory.string,
                    targetArchitecture: nil,
                    releaseConfiguration: false
                )
            )
            print(cargoCommand)
            // runs in sandbox
            /*
            let compileCommand = Command.prebuildCommand(
                 displayName: "Build with Cargo",
                 executable: Path(Cargo.executablePath),
                 arguments: cargoCommand.arguments,
                 outputFilesDirectory: targetDirectory
            )
            commands.append(compileCommand)
            */
            //try cargoCommand.run()
        }
        
        /*
        // copy generated C headers
        if target.name == "CSwiftRust" {
            let command = Command.buildCommand(
                displayName: "Generate Clang module",
                executable: executable,
                arguments: [],
                inputFiles: rustFiles,
                outputFiles: []
            )
            commands.append(command)
        }
        
        // copy generated Swift wrapper
        if let target = target as? SwiftSourceModuleTarget {
            let command = Command.buildCommand(
                displayName: "Copy generated Swift Rust wrapper",
                executable: executable,
                arguments: [
                    "compile",
                    "--manifest-path", manifestPath.string,
                    "--package", rustPackageName,
                    "--target-directory", targetDirectory.string
                ],
                inputFiles: rustFiles,
                outputFiles: []
            )
            commands.append(command)
        }
        */
        return commands
    }
}
