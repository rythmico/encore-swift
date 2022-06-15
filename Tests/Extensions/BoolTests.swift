import Extensions
import XCTest

final class BoolTests: XCTestCase {
    func testNot() {
        XCTAssertTrue(false.not)
        XCTAssertFalse(true.not)
    }

    func testIsTrue() {
        XCTAssertTrue(true.isTrue)
        XCTAssertFalse(false.isTrue)
    }

    func testIsFalse() {
        XCTAssertTrue(false.isFalse)
        XCTAssertFalse(true.isFalse)
    }

    func testAllCases() {
        XCTAssertEqual(Bool.allCases, [false, true])
    }
}
