import DateTimeOnly
import XCTest

final class FoundationSupportTests: XCTestCase {
    func testDate_initFromDateOnly_timeOnly_timeZone() throws {
        let tz = try XCTUnwrap(TimeZone(identifier: "Europe/London"))
        try XCTAssertEqual(
            Date(
                date: DateOnly(year: 2021, month: 10, day: 24), // BST
                time: TimeOnly(hour: 18, minute: 07),
                in: tz
            ),
            "2021-10-24T17:07:00Z"
        )
        try XCTAssertEqual(
            Date(
                date: DateOnly(year: 2021, month: 10, day: 31), // ???
                time: TimeOnly(hour: 00, minute: 00), // BST
                in: tz
            ),
            "2021-10-30T23:00:00Z"
        )
        try XCTAssertEqual(
            Date(
                date: DateOnly(year: 2021, month: 10, day: 31), // ???
                time: TimeOnly(hour: 18, minute: 07), // GMT
                in: tz
            ),
            "2021-10-31T18:07:00Z"
        )
        try XCTAssertEqual(
            Date(
                date: DateOnly(year: 2021, month: 11, day: 01), // GMT
                time: TimeOnly(hour: 18, minute: 07),
                in: tz
            ),
            "2021-11-01T18:07:00Z"
        )
    }
}

extension Date: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = ISO8601DateFormatter().date(from: value)!
    }
}
