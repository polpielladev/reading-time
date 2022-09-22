import XCTest
import ReadingTime

final class ReadingTimeTests: XCTestCase {
    func test_GivenDefaultWPMIsUsed_WhenContentsOfAFileAreProvided_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents)
        
        XCTAssertEqual(calculatedTime, 2)
    }
    
    func test_GivenCustomWPMIsUsed_WhenContentsOfAFileAreProvided_ThenReadingTimeIsReturned() {
        let contents = "Hello World! This is my article!"
        let calculatedTime = ReadingTime.calculate(for: contents, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 360)
    }
    
    func test_WhenInputStringContainsEmojis_ThenTheyAreNotCountedAsWords() throws {
        let contents = "👋 Hello World! 🌍 This is my article! 🗞"
        
        let calculatedTime = ReadingTime.calculate(for: contents, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 360)
    }
    
    func test_GivenDefaultWPMIsUsed_WhenFileURLIsProvided_ThenReadingTimeIsReturned() throws {
        let testFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("test.md")
        try "Hello World! This is my article!".data(using: .utf8)!.write(to: testFileURL)
        
        let calculatedTime = try ReadingTime.calculate(for: testFileURL)
        
        XCTAssertEqual(calculatedTime, 2)

        // Clean up
        try FileManager.default.removeItem(at: testFileURL)
    }
    
    func test_GivenCustomWPMIsUsed_WhenFileURLIsProvided_ThenReadingTimeIsReturned() throws {
        let testFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("test.md")
        try "Hello World! This is my article!".data(using: .utf8)!.write(to: testFileURL)
        
        let calculatedTime = try ReadingTime.calculate(for: testFileURL, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 360)

        // Clean up
        try FileManager.default.removeItem(at: testFileURL)
    }
    
    func test_GivenInvalidURLIsCreated_WhenFileURLIsProvided_ThenErrorIsThrown() throws {
        let testFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("test.md")
        
        XCTAssertThrowsError(try ReadingTime.calculate(for: testFileURL)) { error in
            XCTAssertEqual(error as? ReadingTimeError, .fileNotFound)
        }
    }
    
    func test_GivenAMarkdownStringWithImages_WhenReadingTimeIsCalculated_ThenImagesAreNotCounted() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png) ![my other image](/public/assets/my-other-image)"
        
        let calculatedTime = ReadingTime.calculate(for: textWithImage, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 0)
    }
    
    func test_GivenAMarkdownStringWithLinks_WhenReadingTimeIsCalculated_ThenOnlyLinkTitlesAreComputedTowardsWordCount() {
        let textWithLink = "[My Super Twitter Profile](https://twitter.com/polpielladev)"
        
        let calculatedTime = ReadingTime.calculate(for: textWithLink, wpm: 1)
        
        XCTAssertEqual(calculatedTime, 240)
    }
    
    func test_GivenAMarkdownTestFile_WhenReadingTimeIsCalculated_ThenTimeIsCorrect() throws {
        let fileURL = Bundle.module.url(forResource: "test", withExtension: "md", subdirectory: "MockData")!
        
        let calculatedTime = try ReadingTime.calculate(for: fileURL)
        
        XCTAssertEqual(calculatedTime, 499)
    }
}
