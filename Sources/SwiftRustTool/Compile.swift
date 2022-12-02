//
//  Compile.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation
import ArgumentParser

struct Compile: ParsableCommand {
    
    @Flag(help: "Verbose output.")
    var verbose = false
    
    @Option(help: "Cargo manifest path")
    var manifestPath: String
    
    @Option(help: "Cargo package name")
    var package: String
    
    @Option(help: "Cargo target directory")
    var targetDirectory: String
    
    @Flag(help: "Build for release configuration.")
    var release = false
    
    mutating func run() throws {
        let cargoCommand = Cargo.build(
            Cargo.Build(
                manifestPath: manifestPath,
                package: package,
                targetDirectory: targetDirectory,
                targetArchitecture: nil,
                releaseConfiguration: release
            )
        )
        print(cargoCommand)
        try cargoCommand.run()
    }
}
