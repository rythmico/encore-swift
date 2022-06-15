import Do
import Extensions
import XCTest

final class DateTests: XCTestCase {
    func testReferenceDate() {
        XCTAssertEqual(Date.referenceDate, "2001-01-01T00:00:00Z")
    }

    let sut: Date = "2021-10-24T17:07:00Z"
    let tz = TimeZone(identifier: "Europe/London")!

    func testSet() {
        // BST to BST (DST)
        XCTAssertEqual(try sut => ([], 0, tz), "2021-10-24T17:07:00Z")
        XCTAssertEqual(try sut => (.day, 5, tz), "2021-10-05T17:07:00Z")
        XCTAssertEqual(try sut => (.hour, 1, tz), "2021-10-24T00:07:00Z")
        XCTAssertEqual(try sut => ([.hour, .minute, .second], 1, tz), "2021-10-24T00:01:01Z")
        XCTAssertEqual(try sut => (.day, 5, tz) => ([.hour, .minute, .second], 1, tz), "2021-10-05T00:01:01Z")
        XCTAssertEqual(try sut => ([.hour, .minute, .second], 5, tz) => (.day, 5, tz), "2021-10-05T04:05:05Z")
        // BST to GMT (DST)
        XCTAssertEqual(try sut => (.day, 31, tz), "2021-10-31T18:07:00Z")
        XCTAssertEqual(try sut => (.day, 31, tz) => ([], 0, tz), "2021-10-31T18:07:00Z")
        XCTAssertEqual(try sut => (.day, 31, tz) => (.hour, 1, tz) => (.minute, 59, tz), "2021-10-31T00:59:00Z")
        XCTAssertEqual(try sut => (.day, 31, tz) => (.hour, 2, tz) => (.minute, 0, tz), "2021-10-31T02:00:00Z")
        XCTAssertEqual(try sut => (.day, 31, tz) => (.hour, 17, tz), "2021-10-31T17:07:00Z")
        // TODO: test GMT to BST (DST)
    }

    func testAdd() {
        // BST to BST (DST)
        XCTAssertEqual(try sut + (1, .day, tz), "2021-10-25T17:07:00Z")
        XCTAssertEqual(try sut + (1, .year, tz), "2022-10-24T17:07:00Z")
        XCTAssertEqual(try sut + (3, .year, tz), "2024-10-24T17:07:00Z")
        // BST to GMT (DST)
        XCTAssertEqual(try sut + (1, .weekOfYear, tz), "2021-10-31T18:07:00Z")
        XCTAssertEqual(try sut + (2, .weekOfYear, tz), "2021-11-07T18:07:00Z")
        XCTAssertEqual(try sut + (1, .month, tz), "2021-11-24T18:07:00Z")
    }

    func testSubtract() {
        // BST to BST (DST)
        XCTAssertEqual(sut, try "2021-10-25T17:07:00Z" - (1, .day, tz))
        XCTAssertEqual(sut, try "2022-10-24T17:07:00Z" - (1, .year, tz))
        XCTAssertEqual(sut, try "2024-10-24T17:07:00Z" - (3, .year, tz))
        // GMT to BST (DST)
        XCTAssertEqual(sut, try "2021-10-31T18:07:00Z" - (1, .weekOfYear, tz))
        XCTAssertEqual(sut, try "2021-11-07T18:07:00Z" - (2, .weekOfYear, tz))
        XCTAssertEqual(sut, try "2021-11-24T18:07:00Z" - (1, .month, tz))
    }

    func testDiff() {
        // BST-BST (DST)
        XCTAssertEqual(try sut - ("2021-10-24T17:07:00Z", .second, tz), 0)
        XCTAssertEqual(try sut - ("2021-10-24T17:07:00Z", .day, tz), 0)
        XCTAssertEqual(try sut - ("2021-10-21T17:07:00Z", .day, tz), 3)
        XCTAssertEqual(try sut - ("2011-10-24T17:07:00Z", .year, tz), 10)
        XCTAssertEqual(try sut - ("2011-10-24T17:07:00Z", .month, tz), 120)
        XCTAssertEqual(try sut - ("2021-10-30T17:07:00Z", .hour, tz), -144)
        // BST-GMT (DST)
        XCTAssertEqual(try "2021-10-31T03:00:00Z" - ("2021-10-31T00:00:00Z", .hour, tz), 3)
        XCTAssertEqual(try "2021-10-31T02:00:00Z" - ("2021-10-31T00:00:00Z", .hour, tz), 2)
        XCTAssertEqual(try "2021-10-31T01:00:00Z" - ("2021-10-31T00:00:00Z", .hour, tz), 1)
    }
}
