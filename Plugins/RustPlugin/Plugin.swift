//
//  BuildRust.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation
import PackagePlugin

@main
struct BuildRustPlugin: BuildToolPlugin {
    
    let rustPackageName = "swift-rust-example"
    
    /// This entry point is called when operating on a Swift package.
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        let executable = try context.tool(named: "SwiftRustTool").path
        var commands = [Command]()
        // first compile rust code
        if let target = target as? ClangSourceModuleTarget {
            let command = Command.buildCommand(
                displayName: "Compile Rust sources",
                executable: executable,
                arguments: [
                    "build"
                ],
                inputFiles: [],
                outputFiles: []
            )
            commands.append(command)
        }
        // copy generated C headers
        if let target = target as? ClangSourceModuleTarget {
            let command = Command.buildCommand(
                displayName: "Generate Clang module",
                executable: executable,
                arguments: [],
                inputFiles: [],
                outputFiles: []
            )
            commands.append(command)
        }
        // copy generated Swift wrapper
        if let target = target as? SwiftSourceModuleTarget {
            let command = Command.buildCommand(
                displayName: "Copy generated Swift Rust wrapper",
                executable: executable,
                arguments: [],
                inputFiles: [],
                outputFiles: []
            )
            commands.append(command)
        }
        return commands
    }
}
