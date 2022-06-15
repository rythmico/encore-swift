import DateTimeOnly
import XCTJSONKit

final class TimeOnlyTests: XCTestCase {}

extension TimeOnlyTests {
    func testInit() throws {
        try XCTAssertEqual(
            TimeOnly(hour: 20, minute: 10),
            TimeOnly(hour: 20, minute: 10)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 19, minute: 10),
            TimeOnly(hour: 19, minute: 10)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 18, minute: 15),
            TimeOnly(hour: 18, minute: 15)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 05, minute: 50),
            TimeOnly(hour: 05, minute: 50)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 00, minute: 30),
            TimeOnly(hour: 00, minute: 30)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 00)
        )
        try XCTAssertEqual(
            TimeOnly(hour: .max, minute: .max),
            TimeOnly(hour: 00, minute: 00)
        )

        func assertInitThrows(hour: Int, minute: Int, file: StaticString = #file, line: UInt = #line) {
            XCTAssertThrowsError(try TimeOnly(hour: hour, minute: minute), file: file, line: line) { error in
                switch error {
                case TimeOnlyInitError.invalidDateComponents(let h, let m):
                    XCTAssertEqual(h, hour, file: file, line: line)
                    XCTAssertEqual(m, minute, file: file, line: line)
                    break
                default:
                    XCTFail("Unexpected error received: \(error)")
                }
            }
        }

        assertInitThrows(hour: -1, minute: 12)
        assertInitThrows(hour: -120, minute: 12)
        assertInitThrows(hour: 1, minute: -13)
        assertInitThrows(hour: .min, minute: .min)
    }

    func testInitFromDateAndTimeZone() throws {
        let timeZone = try XCTUnwrap(TimeZone(identifier: "Europe/London"))
        let sut = TimeOnly("2021-10-29T17:30:00Z", in: timeZone)
        XCTAssertEqual(sut.hour, 18)
        XCTAssertEqual(sut.minute, 30)
    }
}

extension TimeOnlyTests {
    func testDecode() throws {
        try XCTAssertJSONDecoding("20:10", TimeOnly(hour: 20, minute: 10))
        try XCTAssertJSONDecoding("19:10", TimeOnly(hour: 19, minute: 10))
        try XCTAssertJSONDecoding("18:15", TimeOnly(hour: 18, minute: 15))
        try XCTAssertJSONDecoding("05:50", TimeOnly(hour: 05, minute: 50))
        try XCTAssertJSONDecoding("00:30", TimeOnly(hour: 00, minute: 30))
        try XCTAssertJSONDecoding("00:00", TimeOnly(hour: 00, minute: 00))
        try XCTAssertJSONDecoding("23:12", TimeOnly(hour: 23, minute: 12))
        try XCTAssertJSONDecoding(" 00:12 ", TimeOnly(hour: 00, minute: 12))

        try XCTAssertThrowsError(XCTAssertJSONDecoding("25:05", TimeOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-12:03", TimeOnly?.none))
    }

    func testEncode() throws {
        try XCTAssertJSONEncoding(TimeOnly(hour: 23, minute: 59), "23:59")
        try XCTAssertJSONEncoding(TimeOnly(hour: 20, minute: 10), "20:10")
        try XCTAssertJSONEncoding(TimeOnly(hour: 19, minute: 10), "19:10")
        try XCTAssertJSONEncoding(TimeOnly(hour: 18, minute: 15), "18:15")
        try XCTAssertJSONEncoding(TimeOnly(hour: 05, minute: 50), "05:50")
        try XCTAssertJSONEncoding(TimeOnly(hour: 00, minute: 30), "00:30")
        try XCTAssertJSONEncoding(TimeOnly(hour: 00, minute: 00), "00:00")
    }
}

extension TimeOnlyTests {
    func testComparable() throws {
        let sut = try [
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 30),
            TimeOnly(hour: 05, minute: 50),
            TimeOnly(hour: 18, minute: 15),
            TimeOnly(hour: 19, minute: 10),
            TimeOnly(hour: 20, minute: 10),
        ]
        XCTAssertEqual(sut, sut.shuffled().sorted())
    }
}

extension TimeOnlyTests {
    func testFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try TimeOnly(hour: 18, minute: 15)
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "18:15")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "18:15:00")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "18:15:00 GMT")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "18:15:00 GMT")
    }

    func testCustomFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try TimeOnly(hour: 18, minute: 15)
        XCTAssertEqual(sut.formatted(custom: "", locale: locale), "")
        XCTAssertEqual(sut.formatted(custom: "HH", locale: locale), "18")
        XCTAssertEqual(sut.formatted(custom: "HHHH", locale: locale), "18")
        XCTAssertEqual(sut.formatted(custom: "mm", locale: locale), "15")
        XCTAssertEqual(sut.formatted(custom: "mmmm", locale: locale), "15")
        XCTAssertEqual(sut.formatted(custom: "HH:mm", locale: locale), "18:15")
    }
}

extension TimeOnlyTests {
    func testLosslessStringConvertible() {
        try XCTAssertEqual(String(TimeOnly(hour: 05, minute: 07)), "05:07")

        try XCTAssertEqual(String(TimeOnly(hour: 13, minute: 25)), "13:25")
    }

    func testCustomStringConvertible() {
        try XCTAssertEqual(String(describing: TimeOnly(hour: 05, minute: 07)), "05:07")
        try XCTAssertEqual(TimeOnly(hour: 05, minute: 07).description, "05:07")
        try XCTAssertEqual("\(TimeOnly(hour: 05, minute: 07))", "05:07")

        try XCTAssertEqual(String(describing: TimeOnly(hour: 13, minute: 25)), "13:25")
        try XCTAssertEqual(TimeOnly(hour: 13, minute: 25).description, "13:25")
        try XCTAssertEqual("\(TimeOnly(hour: 13, minute: 25))", "13:25")
    }

    func testCustomDebugStringConvertible() {
        try XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 05, minute: 07)),
            "TimeOnly(hour: 5, minute: 7)"
        )
        try XCTAssertEqual(
            TimeOnly(hour: 05, minute: 07).debugDescription,
            "TimeOnly(hour: 5, minute: 7)"
        )

        try XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 13, minute: 25)),
            "TimeOnly(hour: 13, minute: 25)"
        )
        try XCTAssertEqual(
            TimeOnly(hour: 13, minute: 25).debugDescription,
            "TimeOnly(hour: 13, minute: 25)"
        )
    }
}

extension TimeOnlyTests {
    func testExpressibleByStringLiteral() {
        try XCTAssertEqual("20:10", TimeOnly(hour: 20, minute: 10))
        try XCTAssertEqual("19:10", TimeOnly(hour: 19, minute: 10))
        try XCTAssertEqual("18:15", TimeOnly(hour: 18, minute: 15))
        try XCTAssertEqual("05:50", TimeOnly(hour: 05, minute: 50))
        try XCTAssertEqual("00:30", TimeOnly(hour: 00, minute: 30))
        try XCTAssertEqual("00:00", TimeOnly(hour: 00, minute: 00))
        try XCTAssertEqual("23:12", TimeOnly(hour: 23, minute: 12))
        try XCTAssertEqual(" 00:12 ", TimeOnly(hour: 00, minute: 12))
    }
}

extension TimeOnlyTests {
    func testInitFromISO8601() {
        XCTAssertEqual(TimeOnly(iso8601: "20:10"), try TimeOnly(hour: 20, minute: 10))
        XCTAssertEqual(TimeOnly(iso8601: "19:10"), try TimeOnly(hour: 19, minute: 10))
        XCTAssertEqual(TimeOnly(iso8601: "18:15"), try TimeOnly(hour: 18, minute: 15))
        XCTAssertEqual(TimeOnly(iso8601: "05:50"), try TimeOnly(hour: 05, minute: 50))
        XCTAssertEqual(TimeOnly(iso8601: "00:30"), try TimeOnly(hour: 00, minute: 30))
        XCTAssertEqual(TimeOnly(iso8601: "00:00"), try TimeOnly(hour: 00, minute: 00))
        XCTAssertEqual(TimeOnly(iso8601: "23:12"), try TimeOnly(hour: 23, minute: 12))
        XCTAssertEqual(TimeOnly(iso8601: " 00:12 "), try TimeOnly(hour: 00, minute: 12))

        XCTAssertEqual(TimeOnly(iso8601: "25:05"), TimeOnly?.none)
        XCTAssertEqual(TimeOnly(iso8601: "-12:03"), TimeOnly?.none)
    }

    func testISO8601Formatting() {
        XCTAssertEqual(try TimeOnly(hour: 23, minute: 59).formatted(style: .iso8601), "23:59")
        XCTAssertEqual(try TimeOnly(hour: 20, minute: 10).formatted(style: .iso8601), "20:10")
        XCTAssertEqual(try TimeOnly(hour: 19, minute: 10).formatted(style: .iso8601), "19:10")
        XCTAssertEqual(try TimeOnly(hour: 18, minute: 15).formatted(style: .iso8601), "18:15")
        XCTAssertEqual(try TimeOnly(hour: 05, minute: 50).formatted(style: .iso8601), "05:50")
        XCTAssertEqual(try TimeOnly(hour: 00, minute: 30).formatted(style: .iso8601), "00:30")
        XCTAssertEqual(try TimeOnly(hour: 00, minute: 00).formatted(style: .iso8601), "00:00")
    }
}

extension TimeOnlyTests {
    func testAdd() throws {
        let sut = try TimeOnly(hour: 05, minute: 07)

        try XCTAssertEqual(sut + (30, .second), TimeOnly(hour: 05, minute: 07))
        try XCTAssertEqual(sut + (60, .second), TimeOnly(hour: 05, minute: 08))
        try XCTAssertEqual(sut + (1, .hour), TimeOnly(hour: 06, minute: 07))
        try XCTAssertEqual(sut + (3, .minute), TimeOnly(hour: 05, minute: 10))
        try XCTAssertEqual(sut + (14, .hour), TimeOnly(hour: 19, minute: 07))
        try XCTAssertEqual(sut + (28, .hour), TimeOnly(hour: 09, minute: 07))

        try XCTAssertEqual(sut + (1, .day), TimeOnly(hour: 05, minute: 07))
        try XCTAssertEqual(sut + (1, .weekOfYear), TimeOnly(hour: 05, minute: 07))
        try XCTAssertEqual(sut + (2, .weekOfYear), TimeOnly(hour: 05, minute: 07))
        try XCTAssertEqual(sut + (3, .month), TimeOnly(hour: 05, minute: 07))
        try XCTAssertEqual(sut + (3, .year), TimeOnly(hour: 05, minute: 07))
    }

    func testSubtract() throws {
        let sut = try TimeOnly(hour: 05, minute: 07)

        try XCTAssertEqual(TimeOnly(hour: 05, minute: 06), TimeOnly(hour: 05, minute: 07) - (30, .second))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 08) - (60, .second))
        try XCTAssertEqual(sut, TimeOnly(hour: 06, minute: 07) - (1, .hour))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 10) - (3, .minute))
        try XCTAssertEqual(sut, TimeOnly(hour: 19, minute: 07) - (14, .hour))
        try XCTAssertEqual(sut, TimeOnly(hour: 09, minute: 07) - (28, .hour))

        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 07) - (1, .day))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 07) - (1, .weekOfYear))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 07) - (2, .weekOfYear))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 07) - (3, .month))
        try XCTAssertEqual(sut, TimeOnly(hour: 05, minute: 07) - (3, .year))
    }

    func testDiff() throws {
        let sut = try TimeOnly(hour: 13, minute: 25)

        try XCTAssertEqual(sut - (TimeOnly(hour: 00, minute: 00), .day), 0)
        try XCTAssertEqual(sut - (TimeOnly(hour: 05, minute: 07), .day), 0)
        try XCTAssertEqual(sut - (TimeOnly(hour: 05, minute: 07), .month), 0)
        try XCTAssertEqual(sut - (TimeOnly(hour: 05, minute: 07), .year), 0)

        try XCTAssertEqual(sut - (TimeOnly(hour: 05, minute: 07), .hour), 8)
        try XCTAssertEqual(sut - (TimeOnly(hour: 13, minute: 22), .hour), 0)
        try XCTAssertEqual(sut - (TimeOnly(hour: 13, minute: 22), .minute), 3)
        try XCTAssertEqual(sut - (TimeOnly(hour: 13, minute: 25), .minute), 0)
        try XCTAssertEqual(sut - (TimeOnly(hour: 13, minute: 24), .second), 60)
        try XCTAssertEqual(sut - (TimeOnly(hour: 05, minute: 25), .second), 8 * 3600)
    }
}
