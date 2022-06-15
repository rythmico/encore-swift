import DateTimeOnly
import XCTest

final class TimeOnlyIntervalTests: XCTestCase {
    func sut() throws -> TimeOnlyInterval {
        try TimeOnlyInterval(
            start: TimeOnly(hour: 17, minute: 15),
            end: TimeOnly(hour: 03, minute: 35)
        )
    }
}

extension TimeOnlyIntervalTests {
    func testInit() throws {
        let sut = try TimeOnlyInterval(
            start: TimeOnly(hour: 17, minute: 15),
            end: TimeOnly(hour: 03, minute: 35)
        )
        XCTAssertEqual(sut.start, try TimeOnly(hour: 17, minute: 15))
        XCTAssertEqual(sut.end, try TimeOnly(hour: 03, minute: 35))
    }
}

extension TimeOnlyIntervalTests {
    func testFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try sut()
        #if os(Linux)
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "17:15–03:35")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "17:15:00 – 03:35:00")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "17:15:00 GMT – 03:35:00 GMT")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "17:15:00 GMT – 03:35:00 GMT")
        #else
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "17:15–03:35")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "17:15:00 – 03:35:00")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "17:15:00 GMT – 03:35:00 GMT")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "17:15:00 GMT – 03:35:00 GMT")
        #endif
    }
}

extension TimeOnlyIntervalTests {
    func testCustomStringConvertible() {
        try XCTAssertEqual(String(describing: sut()), "17:15 - 03:35")
        try XCTAssertEqual(sut().description, "17:15 - 03:35")
        try XCTAssertEqual("\(sut())", "17:15 - 03:35")
    }

    func testCustomDebugStringConvertible() {
        try XCTAssertEqual(
            String(reflecting: sut()),
            "TimeOnlyInterval(start: 17:15, end: 03:35)"
        )
        try XCTAssertEqual(
            sut().debugDescription,
            "TimeOnlyInterval(start: 17:15, end: 03:35)"
        )
    }
}
