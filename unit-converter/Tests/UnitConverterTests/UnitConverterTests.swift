import XCTest
import OSLog
import Foundation
@testable import UnitConverter

let logger: Logger = Logger(subsystem: "UnitConverter", category: "Tests")

@available(macOS 13, *)
final class UnitConverterTests: XCTestCase {
    func testUnitConverter() throws {
        logger.log("running testUnitConverter")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("UnitConverter", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}