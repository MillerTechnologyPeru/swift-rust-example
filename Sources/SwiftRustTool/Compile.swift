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
    
    @Option(help: "The number of times to repeat 'phrase'.")
    var count: Int? = nil

    mutating func run() throws {
        print(self, #function)
    }
}
