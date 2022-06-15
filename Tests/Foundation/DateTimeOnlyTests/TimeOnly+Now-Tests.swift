@testable import DateTimeOnly
import XCTest

extension TimeOnlyTests {
    func testNow() throws {
        let timeZone = try XCTUnwrap(TimeZone(identifier: "Europe/London"))
        now = { "2021-10-29T22:00:00Z" }
        XCTAssertEqual(TimeOnly.now(in: timeZone), "23:00")
        now = { "2021-10-29T23:00:00Z" }
        XCTAssertEqual(TimeOnly.now(in: timeZone), "00:00")
        now = { "2021-10-30T23:00:00Z" }
        XCTAssertEqual(TimeOnly.now(in: timeZone), "00:00")
        now = { "2021-10-31T23:00:00Z" }
        XCTAssertEqual(TimeOnly.now(in: timeZone), "23:00")
        now = { "2021-11-01T23:00:00Z" }
        XCTAssertEqual(TimeOnly.now(in: timeZone), "23:00")
    }
}
