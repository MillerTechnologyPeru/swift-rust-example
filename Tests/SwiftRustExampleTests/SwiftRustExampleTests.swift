import XCTest
@testable import SwiftRustExample

final class SwiftRustExampleTests: XCTestCase {
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftRustExample().text, "Hello, World!")
        
        print_hello_rust()
        
        XCTAssertEqual(rust_add(2, 2), 4)
    }
}
