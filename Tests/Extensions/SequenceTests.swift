import Extensions
import XCTest

final class SequenceTests: XCTestCase {
    func testArray() {
        XCTAssertEqual([Int]().array, [])
        XCTAssertEqual("hello world".array, ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"])
        XCTAssertEqual([1, 2, 3].lazy.array, [1, 2, 3])
        XCTAssertEqual([1, 2, 3].lazy.map { $0 + 1 }.array, [2, 3, 4])
        XCTAssertEqual([1, 2, 3].lazy.filter { $0 > 2 }.map { $0 + 1 }.array, [4])
    }

    func testCountWhere() {
        XCTAssertEqual([3, 2, 1, 3].count(where: { $0 == 0 }), 0)
        XCTAssertEqual([3, 2, 1, 3].count(where: { $0 == 1 }), 1)
        XCTAssertEqual([3, 2, 1, 3].count(where: { $0 == 2 }), 1)
        XCTAssertEqual([3, 2, 1, 3].count(where: { $0 == 3 }), 2)
        XCTAssertEqual([3, 2, 1, 3].count(where: { $0 == 4 }), 0)
    }

    func testSortedByKeyPath() {
        struct Person: Equatable {
            var age: Int
        }
        let a = Person(age: 5)
        let b = Person(age: 3)
        let c = Person(age: 8)
        let d = Person(age: 1)
        XCTAssertEqual([a, b, c, d].sorted(by: \.age), [d, b, a, c])
        XCTAssertEqual([a, b, c, d].sorted(by: \.age, <), [d, b, a, c])
        XCTAssertEqual([a, b, c, d].sorted(by: \.age, >), [c, a, b, d])
    }

    func testMinAndMaxByKeyPath() throws {
        struct Person: Equatable {
            var age: Int
        }
        let a = Person(age: 5)
        let b = Person(age: 3)
        let c = Person(age: 8)
        let d = Person(age: 1)
        XCTAssertEqual([a, b, c, d].min(by: \.age), d)
        XCTAssertEqual([a, b, c, d].min(by: \.age, <), d)
        XCTAssertEqual([a, b, c, d].min(by: \.age, >), c)

        XCTAssertEqual([a, b, c, d].max(by: \.age), c)
        XCTAssertEqual([a, b, c, d].max(by: \.age, <), c)
        XCTAssertEqual([a, b, c, d].max(by: \.age, >), d)

        XCTAssert(try XCTUnwrap([a, b, c, d].minAndMax(by: \.age)) == (d, c))
        XCTAssert(try XCTUnwrap([a, b, c, d].minAndMax(by: \.age, <)) == (d, c))
        XCTAssert(try XCTUnwrap([a, b, c, d].minAndMax(by: \.age, >)) == (c, d))
    }
}
