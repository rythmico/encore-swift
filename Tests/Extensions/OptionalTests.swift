import Extensions
import XCTest

final class OptionalTests: XCTestCase {
    func testEmptyIfNil() {
        XCTAssertEqual([Int]?(nil).emptyIfNil, [])
        XCTAssertEqual([Int]?([]).emptyIfNil, [])
        XCTAssertEqual([Int]?([1]).emptyIfNil, [1])
        XCTAssertEqual([Int]?([1, 2]).emptyIfNil, [1, 2])
        XCTAssertEqual([Int]?([1, 2, 3]).emptyIfNil, [1, 2, 3])
    }

    func testIsNilOrEmpty() {
        XCTAssertEqual([Int]?(nil).isNilOrEmpty, true)
        XCTAssertEqual([Int]?([]).isNilOrEmpty, true)
        XCTAssertEqual([Int]?([1]).isNilOrEmpty, false)
        XCTAssertEqual([Int]?([1, 2]).isNilOrEmpty, false)
        XCTAssertEqual([Int]?([1, 2, 3]).isNilOrEmpty, false)
    }

    func testIsNilOrZero() {
        XCTAssertEqual(Int?.none.isNilOrZero, true)
        XCTAssertEqual(Int?(-2).isNilOrZero, false)
        XCTAssertEqual(Int?(-1).isNilOrZero, false)
        XCTAssertEqual(Int?(0).isNilOrZero, true)
        XCTAssertEqual(Int?(1).isNilOrZero, false)
        XCTAssertEqual(Int?(2).isNilOrZero, false)

        XCTAssertEqual(Float?.none.isNilOrZero, true)
        XCTAssertEqual(Float?(-2).isNilOrZero, false)
        XCTAssertEqual(Float?(-1).isNilOrZero, false)
        XCTAssertEqual(Float?(-0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Float?(0).isNilOrZero, true)
        XCTAssertEqual(Float?(.zero).isNilOrZero, true)
        XCTAssertEqual(Float?(0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Float?(1).isNilOrZero, false)
        XCTAssertEqual(Float?(2).isNilOrZero, false)

        XCTAssertEqual(Double?.none.isNilOrZero, true)
        XCTAssertEqual(Double?(-2).isNilOrZero, false)
        XCTAssertEqual(Double?(-1).isNilOrZero, false)
        XCTAssertEqual(Double?(-0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Double?(0).isNilOrZero, true)
        XCTAssertEqual(Double?(.zero).isNilOrZero, true)
        XCTAssertEqual(Double?(0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Double?(1).isNilOrZero, false)
        XCTAssertEqual(Double?(2).isNilOrZero, false)

        XCTAssertEqual(Decimal?.none.isNilOrZero, true)
        XCTAssertEqual(Decimal?(-2).isNilOrZero, false)
        XCTAssertEqual(Decimal?(-1).isNilOrZero, false)
        XCTAssertEqual(Decimal?(-0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Decimal?(0).isNilOrZero, true)
        XCTAssertEqual(Decimal?(.zero).isNilOrZero, true)
        XCTAssertEqual(Decimal?(0.0000000000000000000000000000000001).isNilOrZero, false)
        XCTAssertEqual(Decimal?(1).isNilOrZero, false)
        XCTAssertEqual(Decimal?(2).isNilOrZero, false)
    }
}
