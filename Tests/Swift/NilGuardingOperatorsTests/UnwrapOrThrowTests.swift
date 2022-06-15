import NilGuardingOperators
import XCTest

final class UnwrapOrThrowTests: XCTestCase {
    func test() {
        // a
        assertThrows(error) {
            try noneA ?! error
        }
        // b
        assertNoThrow(someB) {
            try someB ?! error
        }
        // c
        assertNoThrow(someC) {
            try someC ?! error
        }
        // a b
        assertNoThrow(someB) {
            try noneA ?? someB ?! error
        }
        // a c
        assertNoThrow(someC) {
            try noneA ?? someC ?! error
        }
        // b a
        assertNoThrow(someB) {
            try someB ?? noneA ?! error
        }
        // b c
        assertNoThrow(someB) {
            try someB ?? someC ?! error
        }
        // c a
        assertNoThrow(someC) {
            try someC ?? noneA ?! error
        }
        // c b
        assertNoThrow(someC) {
            try someC ?? someB ?! error
        }
        // a b c
        assertNoThrow(someB) {
            try noneA ?? someB ?? someC ?! error
        }
        // a c b
        assertNoThrow(someC) {
            try noneA ?? someC ?? someB ?! error
        }
        // b a c
        assertNoThrow(someB) {
            try someB ?? noneA ?? someC ?! error
        }
        // b c a
        assertNoThrow(someB) {
            try someB ?? someC ?? noneA ?! error
        }
        // c a b
        assertNoThrow(someC) {
            try someC ?? noneA ?? someB ?! error
        }
        // c b a
        assertNoThrow(someC) {
            try someC ?? someB ?? noneA ?! error
        }
    }
}

private extension UnwrapOrThrowTests {
    func assertThrows<ExpectedError: Error & Equatable, DiscardedResult>(
        _ expectedError: ExpectedError,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: () throws -> DiscardedResult
    ) {
        XCTAssertThrowsError(try closure(), "Expected error was never thrown", file: file, line: line) { error in
            if let error = error as? ExpectedError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Unexpected error was thrown")
            }
        }
    }

    func assertNoThrow<ExpectedResult: Equatable>(
        _ expectedResult: ExpectedResult,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () throws -> ExpectedResult
    ) {
        var result: ExpectedResult?
        XCTAssertNoThrow(try { result = try closure() }(), "Unexpected error was thrown", file: file, line: line)
        XCTAssertEqual(result, expectedResult)
    }
}
