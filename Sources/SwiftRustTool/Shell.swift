//
//  File.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation

func shell(_ command: String) throws {
    print(command)
    let code = _system(command)
    guard code == 0 else {
        throw SwiftRustToolError.shellExitCode(code)
    }
}

@_silgen_name("system")
private func _system(_ command: UnsafePointer<CChar>) -> CInt
