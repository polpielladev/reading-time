import XCTest
import ReadingTime

final class ReadingTimeTests: XCTestCase {
    func test_GivenDefaultWPMIsUsed_WhenContentsOfAFileAreProvider_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents)
        
        XCTAssertEqual(calculatedTime, 1358.49)
    }
    
    func test_GivenCustomWPMIsUsed_WhenContentsOfAFileAreProvider_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 360000.0)
    }
}
