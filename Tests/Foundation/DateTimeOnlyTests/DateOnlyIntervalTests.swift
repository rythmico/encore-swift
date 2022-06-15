import DateTimeOnly
import XCTest

final class DateOnlyIntervalTests: XCTestCase {
    func sut() throws -> DateOnlyInterval {
        try DateOnlyInterval(
            start: DateOnly(year: 2021, month: 10, day: 29),
            end: DateOnly(year: 2021, month: 11, day: 12)
        )
    }
}

extension DateOnlyIntervalTests {
    func testInit() throws {
        let sut = try DateOnlyInterval(
            start: DateOnly(year: 2021, month: 10, day: 29),
            end: DateOnly(year: 2021, month: 11, day: 12)
        )
        XCTAssertEqual(sut.start, try DateOnly(year: 2021, month: 10, day: 29))
        XCTAssertEqual(sut.end, try DateOnly(year: 2021, month: 11, day: 12))
    }
}

extension DateOnlyIntervalTests {
    func testFormat() throws {
        let locale = try XCTUnwrap(Locale(identifier: "en_GB"))
        let sut = try sut()
        #if os(Linux)
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "29/10/2021 – 12/11/2021")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "29 Oct – 12 Nov 2021")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "29 October – 12 November 2021")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "Friday, 29 October – Friday, 12 November 2021")
        #else
        XCTAssertEqual(sut.formatted(style: .none, locale: locale), "")
        XCTAssertEqual(sut.formatted(style: .short, locale: locale), "29/10/2021 – 12/11/2021")
        XCTAssertEqual(sut.formatted(style: .medium, locale: locale), "29 Oct – 12 Nov 2021")
        XCTAssertEqual(sut.formatted(style: .long, locale: locale), "29 October – 12 November 2021")
        XCTAssertEqual(sut.formatted(style: .full, locale: locale), "Friday, 29 October – Friday, 12 November 2021")
        #endif
    }
}

extension DateOnlyIntervalTests {
    func testCustomStringConvertible() {
        try XCTAssertEqual(String(describing: sut()), "2021-10-29 - 2021-11-12")
        try XCTAssertEqual(sut().description, "2021-10-29 - 2021-11-12")
        try XCTAssertEqual("\(sut())", "2021-10-29 - 2021-11-12")
    }

    func testCustomDebugStringConvertible() {
        try XCTAssertEqual(
            String(reflecting: sut()),
            "DateOnlyInterval(start: 2021-10-29, end: 2021-11-12)"
        )
        try XCTAssertEqual(
            sut().debugDescription,
            "DateOnlyInterval(start: 2021-10-29, end: 2021-11-12)"
        )
    }
}
