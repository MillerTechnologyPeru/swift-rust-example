//
//  Error.swift
//  
//
//  Created by Alsey Coleman Miller on 12/1/22.
//

import Foundation

enum SwiftRustToolError: Error {
    
    case shellExitCode(CInt)
}
