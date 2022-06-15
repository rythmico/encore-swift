import DateTimeOnly
import Extensions
import PeriodDuration
import XCTest

final class TimeOnlyTests: XCTestCase {
    let sut = try! TimeOnly(hour: 17, minute: 24)

    func testAddPeriod() throws {
        try XCTAssertEqual(sut + Period(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(days: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(years: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(days: 7), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(years: 2, months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Period(years: 2, months: 1, days: 8), TimeOnly(hour: 17, minute: 24))
    }

    func testSubtractPeriod() throws {
        try XCTAssertEqual(sut - Period(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(days: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(years: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(days: 7), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(years: 2, months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Period(years: 2, months: 1, days: 8), TimeOnly(hour: 17, minute: 24))
    }

    func testAddDuration() throws {
        try XCTAssertEqual(sut + Duration(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 1), TimeOnly(hour: 18, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 12), TimeOnly(hour: 05, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 24), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 3, minutes: 5), TimeOnly(hour: 20, minute: 29))
        try XCTAssertEqual(sut + Duration(hours: 48, minutes: 24 * 60), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + Duration(hours: 48, minutes: 24 * 60, seconds: 24 * 3600), TimeOnly(hour: 17, minute: 24))
    }

    func testSubtractDuration() throws {
        try XCTAssertEqual(sut - Duration(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 1), TimeOnly(hour: 16, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 12), TimeOnly(hour: 05, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 24), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 3, minutes: 5), TimeOnly(hour: 14, minute: 19))
        try XCTAssertEqual(sut - Duration(hours: 48, minutes: 24 * 60), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - Duration(hours: 48, minutes: 24 * 60, seconds: 24 * 3600), TimeOnly(hour: 17, minute: 24))
    }

    func testAddPeriodDuration() throws {
        try XCTAssertEqual(sut + PeriodDuration(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 11 * 3600), TimeOnly(hour: 16, minute: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600), TimeOnly(hour: 17, minute: 24))
    }

    func testSubtractPeriodDuration() throws {
        try XCTAssertEqual(sut - PeriodDuration(), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 11 * 3600), TimeOnly(hour: 18, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600), TimeOnly(hour: 17, minute: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600 + 1), TimeOnly(hour: 17, minute: 23))
    }
}
