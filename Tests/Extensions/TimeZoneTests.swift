import Extensions
import XCTest

final class TimeZoneTests: XCTestCase {
    func testID() {
        XCTAssertEqual(TimeZone(identifier: "Europe/London")?.id, "Europe/London")
        XCTAssertEqual(TimeZone(id: "Europe/London")?.identifier, "Europe/London")
    }
}
