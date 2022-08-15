import XCTest
import ReadingTime

class MarkdownRewriterTests: XCTestCase {
    func test_GivenAMarkdownStringWithImages_ThenImagesAreRemovedFromText() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png)"
        
        let textWithNoImages = MarkdownRewriter(text: textWithImage)
            .rewrite()
    
        XCTAssertEqual(textWithNoImages, "")
    }
    
    func test_GivenAMarkdownStringWithLinks_ThenOnlyLinkTextIsKept() {
        let textWithLinks = "[Pol Piella](https://www.polpiella.dev/about)"
        
        let rewrittenText = MarkdownRewriter(text: textWithLinks)
            .rewrite()
        
        XCTAssertEqual("Pol Piella", rewrittenText)
    }
}
