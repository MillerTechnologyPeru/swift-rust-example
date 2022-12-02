//
//  Compile.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation
import ArgumentParser

struct Compile: ParsableCommand {
    
    @Option(help: "Cargo manifest path")
    var manifestPath: String
    
    @Option(help: "Cargo target directory")
    var targetDirectory: String
    
    @Option(help: "Cargo package name")
    var package: String?
    
    @Flag(help: "Build for release configuration.")
    var release = false
    
    @Flag(help: "Verbose output.")
    var verbose = false
    
    mutating func run() throws {
        // run cargo
        let cargoCommand = Cargo.build(
            Cargo.Build(
                manifestPath: manifestPath,
                package: package,
                targetDirectory: targetDirectory,
                targetArchitecture: nil,
                releaseConfiguration: release
            )
        )
        let command = "export PATH=$PATH:/opt/homebrew/bin CARGO_HOME=\(targetDirectory) && " + cargoCommand.command + " --offline"
        try? shell(command)
    }
}
