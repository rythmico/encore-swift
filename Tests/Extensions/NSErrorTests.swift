import Extensions
import XCTest

final class NSErrorTests: XCTestCase {
    func testInitWithDomainCodeLocalizedDescription() {
        let sut = NSError(domain: "ErrorExtensionDomain", code: -1, localizedDescription: "Lorem ipsum")
        XCTAssertEqual(sut.domain, "ErrorExtensionDomain")
        XCTAssertEqual(sut.code, -1)
        XCTAssertEqual(sut.localizedDescription, "Lorem ipsum")
        XCTAssertEqual((sut as Error).localizedDescription, "Lorem ipsum")
    }
}
