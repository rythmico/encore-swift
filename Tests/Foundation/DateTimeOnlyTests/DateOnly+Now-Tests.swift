import DateTimeOnly
@testable import var DateTimeOnly.now
import XCTest

extension DateOnlyTests {
    func testNow() throws {
        let timeZone = try XCTUnwrap(TimeZone(identifier: "Europe/London"))
        now = { "2021-10-29T22:00:00Z" }
        XCTAssertEqual(DateOnly.now(in: timeZone), "2021-10-29")
        now = { "2021-10-29T23:00:00Z" }
        XCTAssertEqual(DateOnly.now(in: timeZone), "2021-10-30")
        now = { "2021-10-30T23:00:00Z" }
        XCTAssertEqual(DateOnly.now(in: timeZone), "2021-10-31")
        now = { "2021-10-31T23:00:00Z" }
        XCTAssertEqual(DateOnly.now(in: timeZone), "2021-10-31")
        now = { "2021-11-01T23:00:00Z" }
        XCTAssertEqual(DateOnly.now(in: timeZone), "2021-11-01")
    }
}
