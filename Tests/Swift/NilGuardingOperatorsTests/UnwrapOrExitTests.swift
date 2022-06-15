import ErrorAssertionExpectations
import NilGuardingOperators
import XCTest

final class UnwrapOrExitTests: XCTestCase {
    func test() {
        // a
        XCTAssertExit {
            noneA !! exit()
        }
        // b
        XCTAssertNoExit(someB) {
            someB !! exit()
        }
        // c
        XCTAssertNoExit(someC) {
            someC !! exit()
        }
        // a b
        XCTAssertNoExit(someB) {
            noneA ?? someB !! exit()
        }
        // a c
        XCTAssertNoExit(someC) {
            noneA ?? someC !! exit()
        }
        // b a
        XCTAssertNoExit(someB) {
            someB ?? noneA !! exit()
        }
        // b c
        XCTAssertNoExit(someB) {
            someB ?? someC !! exit()
        }
        // c a
        XCTAssertNoExit(someC) {
            someC ?? noneA !! exit()
        }
        // c b
        XCTAssertNoExit(someC) {
            someC ?? someB !! exit()
        }
        // a b c
        XCTAssertNoExit(someB) {
            noneA ?? someB ?? someC !! exit()
        }
        // a c b
        XCTAssertNoExit(someC) {
            noneA ?? someC ?? someB !! exit()
        }
        // b a c
        XCTAssertNoExit(someB) {
            someB ?? noneA ?? someC !! exit()
        }
        // b c a
        XCTAssertNoExit(someB) {
            someB ?? someC ?? noneA !! exit()
        }
        // c a b
        XCTAssertNoExit(someC) {
            someC ?? noneA ?? someB !! exit()
        }
        // c b a
        XCTAssertNoExit(someC) {
            someC ?? someB ?? noneA !! exit()
        }
    }
}

private extension UnwrapOrExitTests {
    func XCTAssertExit<DiscardedResult>(
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () -> DiscardedResult
    ) {
        expectFatalError(file: file, line: line) { _ = closure() }
    }

    func XCTAssertNoExit<ExpectedResult: Equatable>(
        _ expectedResult: ExpectedResult,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () -> ExpectedResult
    ) {
        expectNoFatalError(file: file, line: line) {
            let result = closure()
            XCTAssertEqual(result, expectedResult, file: file, line: line)
        }
    }
}
