import XCTest
import OSLog
import Foundation
@testable import GuessTheFlag

let logger: Logger = Logger(subsystem: "GuessTheFlag", category: "Tests")

@available(macOS 13, *)
final class GuessTheFlagTests: XCTestCase {
    func testGuessTheFlag() throws {
        logger.log("running testGuessTheFlag")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("GuessTheFlag", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}