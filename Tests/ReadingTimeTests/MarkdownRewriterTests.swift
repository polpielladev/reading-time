import XCTest
import ReadingTime

class MarkdownRewriterTests: XCTestCase {
    func test_GivenAMarkdownStringWithImages_ThenImagesAreRemovedFromText() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png)"
        
        let (textWithNoImages, _) = MarkdownRewriter(text: textWithImage)
            .rewrite()
    
        XCTAssertEqual(textWithNoImages, "")
    }
    
    func test_GivenAMarkdownStringWithImages_ThenImageCountIsKept() {
        let textWithImages = "![my nice image](/public/assets/my-nice-image.png) ![my other image](/public/assets/my-other-image.png)"
        
        let (_, imageCount) = MarkdownRewriter(text: textWithImages)
            .rewrite()
        
        XCTAssertEqual(imageCount, 2)
    }
}
