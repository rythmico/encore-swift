import DateTimeOnly
import XCTJSONKit

final class DateOnlyTests: XCTestCase {}

extension DateOnlyTests {
    func testInit() throws {
        try XCTAssertEqual(
            DateOnly(year: 10300, month: 07, day: 14),
            DateOnly(year: 10300, month: 07, day: 14)
        )
        try XCTAssertEqual(
            DateOnly(year: 2021, month: 07, day: 14),
            DateOnly(year: 2021, month: 07, day: 14)
        )
        try XCTAssertEqual(
            DateOnly(year: 2019, month: 12, day: 03),
            DateOnly(year: 2019, month: 12, day: 03)
        )
        try XCTAssertEqual(
            DateOnly(year: 103, month: 12, day: 03),
            DateOnly(year: 103, month: 12, day: 03)
        )
        try XCTAssertEqual(
            DateOnly(year: 1, month: 12, day: 03),
            DateOnly(year: 1, month: 12, day: 03)
        )
        try XCTAssertEqual(
            DateOnly(year: .max, month: .max, day: .max),
            DateOnly(year: 0001, month: 01, day: 01)
        )

        func assertInitThrows(year: Int, month: Int, day: Int, file: StaticString = #file, line: UInt = #line) {
            XCTAssertThrowsError(try DateOnly(year: year, month: month, day: day), file: file, line: line) { error in
                switch error {
                case DateOnlyInitError.invalidDateComponents(let y, let m, let d):
                    XCTAssertEqual(y, year, file: file, line: line)
                    XCTAssertEqual(m, month, file: file, line: line)
                    XCTAssertEqual(d, day, file: file, line: line)
                    break
                default:
                    XCTFail("Unexpected error received: \(error)")
                }
            }
        }

        assertInitThrows(year: 0, month: 12, day: 03)
        assertInitThrows(year: -1, month: 12, day: 03)
        assertInitThrows(year: -120, month: 12, day: 03)
        assertInitThrows(year: -120, month: 13, day: 03)
        assertInitThrows(year: .min, month: .min, day: .min)
    }

    func testInitFromDateAndTimeZone() throws {
        let timeZone = try XCTUnwrap(TimeZone(identifier: "Europe/London"))
        let sut = DateOnly("2021-10-29T23:00:00Z", in: timeZone)
        XCTAssertEqual(sut.year, 2021)
        XCTAssertEqual(sut.month, 10)
        XCTAssertEqual(sut.day, 30)
    }
}

extension DateOnlyTests {
    func testDecode() throws {
        try XCTAssertJSONDecoding("10300-07-14", DateOnly(year: 10300, month: 07, day: 14))
        try XCTAssertJSONDecoding("2021-07-14", DateOnly(year: 2021, month: 07, day: 14))
        try XCTAssertJSONDecoding("2019-12-03", DateOnly(year: 2019, month: 12, day: 03))
        try XCTAssertJSONDecoding("0103-12-03", DateOnly(year: 103, month: 12, day: 03))
        try XCTAssertJSONDecoding("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertJSONDecoding("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertJSONDecoding("0002-12-03", DateOnly(year: 2, month: 12, day: 03))
        try XCTAssertJSONDecoding(" 0121-12-03 ", DateOnly(year: 121, month: 12, day: 03))

        try XCTAssertThrowsError(XCTAssertJSONDecoding("12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-0001-12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-0120-12-03", DateOnly?.none))
    }

    func testEncode() throws {
        try XCTAssertJSONEncoding(DateOnly(year: 10300, month: 07, day: 14), "10300-07-14")
        try XCTAssertJSONEncoding(DateOnly(year: 2021, month: 07, day: 14), "2021-07-14")
        try XCTAssertJSONEncoding(DateOnly(year: 2019, month: 12, day: 03), "2019-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: 103, month: 12, day: 03), "0103-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: 1, month: 12, day: 03), "0001-12-03")
        #if !os(Linux)
        try XCTAssertJSONEncoding(DateOnly(year: .max, month: .max, day: .max), "0001-01-01")
        #endif
    }
}

extension DateOnlyTests {
    func testComparable() throws {
        let sut = try [
            DateOnly(year: 2019, month: 11, day: 14),
            DateOnly(year: 2020, month: 07, day: 03),
            DateOnly(year: 2020, month: 07, day: 03),
            DateOnly(year: 2021, month: 06, day: 02),
            DateOnly(year: 2021, month: 06, day: 03),
            DateOnly(year: 2021, month: 07, day: 02),
            DateOnly(year: 2021, month: 07, day: 03),
        ]
        XCTAssertEqual(sut, sut.shuffled().sorted())
    }
}

extension DateOnlyTests {
    func testFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try DateOnly(year: 2019, month: 11, day: 14)
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "14/11/2019")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "14 Nov 2019")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "14 November 2019")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "Thursday, 14 November 2019")
    }

    func testCustomFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try DateOnly(year: 2019, month: 11, day: 14)
        XCTAssertEqual(sut.formatted(custom: "", locale: locale), "")
        XCTAssertEqual(sut.formatted(custom: "EEEE", locale: locale), "Thursday")
        #if os(Linux)
        XCTAssertEqual(sut.formatted(custom: "EEEE d MMMM", locale: locale), "Thursday, 14 November")
        #else
        XCTAssertEqual(sut.formatted(custom: "EEEE d MMMM", locale: locale), "Thursday 14 November")
        #endif
    }
}

extension DateOnlyTests {
    func testLosslessStringConvertible() {
        try XCTAssertEqual(String(DateOnly(year: 2020, month: 02, day: 29)), "2020-02-29")
    }

    func testCustomStringConvertible() {
        try XCTAssertEqual(String(describing: DateOnly(year: 2020, month: 02, day: 29)), "2020-02-29")
        try XCTAssertEqual(DateOnly(year: 2020, month: 02, day: 29).description, "2020-02-29")
        try XCTAssertEqual("\(DateOnly(year: 2020, month: 02, day: 29))", "2020-02-29")
    }

    func testCustomDebugStringConvertible() {
        try XCTAssertEqual(
            String(reflecting: DateOnly(year: 2020, month: 02, day: 29)),
            "DateOnly(year: 2020, month: 2, day: 29)"
        )
        try XCTAssertEqual(
            DateOnly(year: 2020, month: 02, day: 29).debugDescription,
            "DateOnly(year: 2020, month: 2, day: 29)"
        )
    }
}

extension DateOnlyTests {
    func testExpressibleByStringLiteral() {
        try XCTAssertEqual("10300-07-14", DateOnly(year: 10300, month: 07, day: 14))
        try XCTAssertEqual("2021-07-14", DateOnly(year: 2021, month: 07, day: 14))
        try XCTAssertEqual("2019-12-03", DateOnly(year: 2019, month: 12, day: 03))
        try XCTAssertEqual("0103-12-03", DateOnly(year: 103, month: 12, day: 03))
        try XCTAssertEqual("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertEqual("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertEqual("0002-12-03", DateOnly(year: 2, month: 12, day: 03))
        try XCTAssertEqual(" 0121-12-03 ", DateOnly(year: 121, month: 12, day: 03))
    }
}

extension DateOnlyTests {
    func testInitFromISO8601() {
        XCTAssertEqual(DateOnly(iso8601: "10300-07-14"), try DateOnly(year: 10300, month: 07, day: 14))
        XCTAssertEqual(DateOnly(iso8601: "2021-07-14"), try DateOnly(year: 2021, month: 07, day: 14))
        XCTAssertEqual(DateOnly(iso8601: "2019-12-03"), try DateOnly(year: 2019, month: 12, day: 03))
        XCTAssertEqual(DateOnly(iso8601: "0103-12-03"), try DateOnly(year: 103, month: 12, day: 03))
        XCTAssertEqual(DateOnly(iso8601: "0001-12-03"), try DateOnly(year: 1, month: 12, day: 03))
        XCTAssertEqual(DateOnly(iso8601: "0001-12-03"), try DateOnly(year: 1, month: 12, day: 03))
        XCTAssertEqual(DateOnly(iso8601: "0002-12-03"), try DateOnly(year: 2, month: 12, day: 03))
        XCTAssertEqual(DateOnly(iso8601: " 0121-12-03 "), try DateOnly(year: 121, month: 12, day: 03))

        XCTAssertEqual(DateOnly(iso8601: "12-03"), DateOnly?.none)
        XCTAssertEqual(DateOnly(iso8601: "-12-03"), DateOnly?.none)
        XCTAssertEqual(DateOnly(iso8601: "-0001-12-03"), DateOnly?.none)
        XCTAssertEqual(DateOnly(iso8601: "-0120-12-03"), DateOnly?.none)
    }

    func testISO8601Formatting() {
        XCTAssertEqual(try DateOnly(year: 10300, month: 07, day: 14).formatted(style: .iso8601), "10300-07-14")
        XCTAssertEqual(try DateOnly(year: 2021, month: 07, day: 14).formatted(style: .iso8601), "2021-07-14")
        XCTAssertEqual(try DateOnly(year: 2019, month: 12, day: 03).formatted(style: .iso8601), "2019-12-03")
        XCTAssertEqual(try DateOnly(year: 103, month: 12, day: 03).formatted(style: .iso8601), "0103-12-03")
        XCTAssertEqual(try DateOnly(year: 1, month: 12, day: 03).formatted(style: .iso8601), "0001-12-03")
    }
}

extension DateOnlyTests {
    func testAdd() throws {
        let sut = try DateOnly(year: 2021, month: 10, day: 24)
        // BST to BST (DST) — but not really
        try XCTAssertEqual(sut + (1, .day), DateOnly(year: 2021, month: 10, day: 25))
        try XCTAssertEqual(sut + (3, .month), DateOnly(year: 2022, month: 01, day: 24))
        try XCTAssertEqual(sut + (3, .year), DateOnly(year: 2024, month: 10, day: 24))
        // BST to GMT (DST) — but not really
        try XCTAssertEqual(sut + (1, .weekOfYear), DateOnly(year: 2021, month: 10, day: 31))
        try XCTAssertEqual(sut + (2, .weekOfYear), DateOnly(year: 2021, month: 11, day: 07))
        try XCTAssertEqual(sut + (1, .month), DateOnly(year: 2021, month: 11, day: 24))
    }

    func testAdd_toLeapDay() throws {
        let sut = try DateOnly(year: 2020, month: 02, day: 29) // leap day
        try XCTAssertEqual(sut + (3, .day), DateOnly(year: 2020, month: 03, day: 03))
        try XCTAssertEqual(sut + (3, .month), DateOnly(year: 2020, month: 05, day: 29))
        try XCTAssertEqual(sut + (3, .year), DateOnly(year: 2023, month: 02, day: 28))
    }

    func testSubtract() throws {
        let sut = try DateOnly(year: 2021, month: 10, day: 24)
        // BST to BST (DST) — but not really
        try XCTAssertEqual(sut, DateOnly(year: 2021, month: 10, day: 25) - (1, .day))
        try XCTAssertEqual(sut, DateOnly(year: 2022, month: 01, day: 24) - (3, .month))
        try XCTAssertEqual(sut, DateOnly(year: 2024, month: 10, day: 24) - (3, .year))
        // GMT to BST (DST) — but not really
        try XCTAssertEqual(sut, DateOnly(year: 2021, month: 10, day: 31) - (1, .weekOfYear))
        try XCTAssertEqual(sut, DateOnly(year: 2021, month: 11, day: 07) - (2, .weekOfYear))
        try XCTAssertEqual(sut, DateOnly(year: 2021, month: 11, day: 24) - (1, .month))
    }

    func testSubtract_toLeapDay() throws {
        let sut = try DateOnly(year: 2020, month: 02, day: 29) // leap day
        try XCTAssertEqual(sut, DateOnly(year: 2020, month: 03, day: 03) - (3, .day))
        try XCTAssertEqual(sut, DateOnly(year: 2020, month: 05, day: 29) - (3, .month))
        try XCTAssertGreaterThan(sut, DateOnly(year: 2023, month: 02, day: 28) - (3, .year))
        try XCTAssertEqual(sut - (1, .day), DateOnly(year: 2023, month: 02, day: 28) - (3, .year))
    }

    func testDiff() throws {
        let sut = try DateOnly(year: 2021, month: 10, day: 24) // leap day
        // BST-BST (DST) — but not really
        try XCTAssertEqual(sut - (DateOnly(year: 2021, month: 10, day: 24), .day), 0)
        try XCTAssertEqual(sut - (DateOnly(year: 2021, month: 10, day: 21), .day), 3)
        try XCTAssertEqual(sut - (DateOnly(year: 2011, month: 10, day: 24), .year), 10)
        try XCTAssertEqual(sut - (DateOnly(year: 2011, month: 10, day: 24), .month), 120)
        try XCTAssertEqual(sut - (DateOnly(year: 2021, month: 10, day: 30), .hour), -144)
    }
}
