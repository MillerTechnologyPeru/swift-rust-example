//
//  BuildRust.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation
import ArgumentParser

@main
struct SwiftRustTool: AsyncParsableCommand {
    
    static let configuration = CommandConfiguration(
        commandName: "SwiftRustTool",
        abstract: "Command line tool for compiling Rust with Swift interoperability",
        version: "1.0.0",
        subcommands: [
            Compile.self
        ]
    )
}
