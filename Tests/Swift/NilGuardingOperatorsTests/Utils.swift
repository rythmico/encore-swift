import ErrorAssertions
import XCTest

// Possible permutations:
//   - a
//   - b
//   - c
//   - a b
//   - a c
//   - b a
//   - b c
//   - c a
//   - c b
//   - a b c
//   - a c b
//   - b a c
//   - b c a
//   - c a b
//   - c b a

let noneA = String?.none
let someB = String?.some("B")
let someC = String?.some("C")

let error = NSError(domain: XCTestErrorDomain, code: -1, userInfo: nil)
let exit = { ErrorAssertions.fatalError() }
