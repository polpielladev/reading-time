import XCTest
@testable import ReadingTime

enum ReadingTime {
    static func calculate(for content: String, wpm: Int = 265) -> TimeInterval {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = content.components(separatedBy: chararacterSet)
        let words = components.filter { !$0.isEmpty }
        let timeIntervalInMinutes = Double(words.count) / Double(wpm)
        let timeIntervalInMilliseconds = timeIntervalInMinutes * 60 * 1000

        return round(timeIntervalInMilliseconds * 100) / 100.0
    }
}

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
