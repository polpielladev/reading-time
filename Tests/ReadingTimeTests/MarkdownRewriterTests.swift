import XCTest
import ReadingTime

struct MarkdownRewriter {
    let text: String
    
    func rewrite() {
        
    }
}

class MarkdownRewriterTests: XCTestCase {
    func test_GivenAMarkdownStringWithImages_ThenImagesAreRemovedFromText() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png)"
        
        let textWithNoImages = MarkdownRewriter(text: textWithImage)
            .rewrite()
    }
}
