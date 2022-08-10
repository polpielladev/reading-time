import XCTest
@testable import ReadingTime

enum ReadingTime {
    static func calculate(for content: String) {
        
    }
}

final class ReadingTimeTests: XCTestCase {
    func test_WhenContentsOfAFileAreProvider_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents)
    }
}
