import Extensions
import XCTest

final class ResultTests: XCTestCase {
    struct MockError: Error, Equatable, ExpressibleByStringLiteral {
        var value: String

        init(stringLiteral value: StringLiteralType) {
            self.value = value
        }
    }

    typealias Result = Swift.Result<Int, MockError>

    func testInitWithValueAndError() {
        XCTAssertEqual(Result(value: 3, error: "Error"), .success(3))
        XCTAssertEqual(Result(value: 3, error: nil), .success(3))
        XCTAssertEqual(Result(value: nil, error: "Error"), .failure("Error"))
        XCTAssertNil(Result(value: nil, error: nil))
    }

    func testValue() {
        XCTAssertEqual(Result.success(3).value, 3)
        XCTAssertEqual(Result.failure("Error").value, nil)
    }

    func testError() {
        XCTAssertEqual(Result.success(3).error, nil)
        XCTAssertEqual(Result.failure("Error").error, "Error")
    }

    func testIsSuccess() {
        XCTAssertEqual(Result.success(3).isSuccess, true)
        XCTAssertEqual(Result.failure("Error").isSuccess, false)
    }

    func testIsFailure() {
        XCTAssertEqual(Result.success(3).isFailure, false)
        XCTAssertEqual(Result.failure("Error").isFailure, true)
    }
}
