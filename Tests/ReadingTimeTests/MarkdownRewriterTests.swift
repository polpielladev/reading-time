import XCTest
import ReadingTime

class MarkdownRewriterTests: XCTestCase {
    func test_GivenAMarkdownStringWithImages_ThenImagesAreRemovedFromText() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png)"
        
        let textWithNoImages = MarkdownRewriter(text: textWithImage)
            .rewrite()
    
        XCTAssertEqual(textWithNoImages, "")
    }
}
