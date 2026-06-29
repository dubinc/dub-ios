import XCTest
@testable import Dub

final class DubTests: XCTestCase {
    func testDeferredDeepLinkSkipsPasteboardReadWhenNoProbableURL() {
        var readCount = 0
        let result = Dub.deferredDeepLink(hasProbableURL: false) {
            readCount += 1
            return "https://ref.example.com/abc"
        }

        XCTAssertNil(result)
        XCTAssertEqual(readCount, 0, "The pasteboard value must not be read when no probable URL is present.")
    }

    func testDeferredDeepLinkReadsPasteboardValueWhenProbableURLPresent() {
        var readCount = 0
        let result = Dub.deferredDeepLink(hasProbableURL: true) {
            readCount += 1
            return "https://ref.example.com/abc"
        }

        XCTAssertEqual(result, "https://ref.example.com/abc")
        XCTAssertEqual(readCount, 1)
    }

    func testDeferredDeepLinkReturnsNilWhenPasteboardEmptyDespiteDetection() {
        let result = Dub.deferredDeepLink(hasProbableURL: true) { nil }

        XCTAssertNil(result)
    }
}
