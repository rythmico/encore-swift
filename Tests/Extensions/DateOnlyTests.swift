import DateTimeOnly
import Extensions
import PeriodDuration
import XCTest

final class DateOnlyTests: XCTestCase {
    let sut = try! DateOnly(year: 2021, month: 10, day: 24)

    func testAddPeriod() throws {
        try XCTAssertEqual(sut + Period(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut + Period(days: 1), DateOnly(year: 2021, month: 10, day: 25))
        try XCTAssertEqual(sut + Period(years: 1), DateOnly(year: 2022, month: 10, day: 24))
        try XCTAssertEqual(sut + Period(days: 7), DateOnly(year: 2021, month: 10, day: 31))
        try XCTAssertEqual(sut + Period(months: 3), DateOnly(year: 2022, month: 01, day: 24))
        try XCTAssertEqual(sut + Period(years: 2, months: 3), DateOnly(year: 2024, month: 01, day: 24))
        try XCTAssertEqual(sut + Period(years: 2, months: 1, days: 8), DateOnly(year: 2023, month: 12, day: 02))
    }

    func testSubtractPeriod() throws {
        try XCTAssertEqual(sut - Period(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut - Period(days: 1), DateOnly(year: 2021, month: 10, day: 23))
        try XCTAssertEqual(sut - Period(years: 1), DateOnly(year: 2020, month: 10, day: 24))
        try XCTAssertEqual(sut - Period(days: 7), DateOnly(year: 2021, month: 10, day: 17))
        try XCTAssertEqual(sut - Period(months: 3), DateOnly(year: 2021, month: 07, day: 24))
        try XCTAssertEqual(sut - Period(years: 2, months: 3), DateOnly(year: 2019, month: 07, day: 24))
        try XCTAssertEqual(sut - Period(years: 2, months: 1, days: 8), DateOnly(year: 2019, month: 09, day: 16))
    }

    func testAddDuration() throws {
        try XCTAssertEqual(sut + Duration(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut + Duration(hours: 1), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut + Duration(hours: 12), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut + Duration(hours: 24), DateOnly(year: 2021, month: 10, day: 25))
        try XCTAssertEqual(sut + Duration(hours: 48), DateOnly(year: 2021, month: 10, day: 26))
        try XCTAssertEqual(sut + Duration(hours: 48, minutes: 24 * 60), DateOnly(year: 2021, month: 10, day: 27))
        try XCTAssertEqual(sut + Duration(hours: 48, minutes: 24 * 60, seconds: 24 * 3600), DateOnly(year: 2021, month: 10, day: 28))
    }

    func testSubtractDuration() throws {
        try XCTAssertEqual(sut - Duration(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut - Duration(hours: 1), DateOnly(year: 2021, month: 10, day: 23))
        try XCTAssertEqual(sut - Duration(hours: 12), DateOnly(year: 2021, month: 10, day: 23))
        try XCTAssertEqual(sut - Duration(hours: 24), DateOnly(year: 2021, month: 10, day: 23))
        try XCTAssertEqual(sut - Duration(hours: 48), DateOnly(year: 2021, month: 10, day: 22))
        try XCTAssertEqual(sut - Duration(hours: 48, minutes: 24 * 60), DateOnly(year: 2021, month: 10, day: 21))
        try XCTAssertEqual(sut - Duration(hours: 48, minutes: 24 * 60, seconds: 24 * 3600), DateOnly(year: 2021, month: 10, day: 20))
    }

    func testAddPeriodDuration() throws {
        try XCTAssertEqual(sut + PeriodDuration(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1), DateOnly(year: 2022, month: 10, day: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3), DateOnly(year: 2023, month: 01, day: 24))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, hours: 48), DateOnly(year: 2023, month: 01, day: 26))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48), DateOnly(year: 2023, month: 01, day: 29))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 11 * 3600), DateOnly(year: 2023, month: 01, day: 29))
        try XCTAssertEqual(sut + PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600), DateOnly(year: 2023, month: 01, day: 30))
    }

    func testSubtractPeriodDuration() throws {
        try XCTAssertEqual(sut - PeriodDuration(), DateOnly(year: 2021, month: 10, day: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1), DateOnly(year: 2020, month: 10, day: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3), DateOnly(year: 2020, month: 07, day: 24))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, hours: 48), DateOnly(year: 2020, month: 07, day: 22))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48), DateOnly(year: 2020, month: 07, day: 19))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 11 * 3600), DateOnly(year: 2020, month: 07, day: 18))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600), DateOnly(year: 2020, month: 07, day: 18))
        try XCTAssertEqual(sut - PeriodDuration(years: 1, months: 3, days: 3, hours: 48, minutes: 12 * 60, seconds: 12 * 3600 + 1), DateOnly(year: 2020, month: 07, day: 17))
    }
}
