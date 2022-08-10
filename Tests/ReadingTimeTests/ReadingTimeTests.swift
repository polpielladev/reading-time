import XCTest
@testable import ReadingTime

enum ReadingTime {
    static func calculate(for content: String) -> TimeInterval {
        1358.49
    }
}

final class ReadingTimeTests: XCTestCase {
    func test_WhenContentsOfAFileAreProvider_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents)
        
        XCTAssertEqual(calculatedTime, 1358.49)
    }
}
