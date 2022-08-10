import XCTest
import ReadingTime
import Markdown

struct Rewriter: MarkupRewriter {
    func visitImage(_ image: Image) -> Markup? {
        return nil
    }
}

struct MarkdownRewriter {
    let text: String
    
    func rewrite() -> String {
        let document = Document(parsing: text)
        var rewriter = Rewriter()
        let updatedDocument = rewriter.visitDocument(document)
        return updatedDocument!.format()
    }
}

class MarkdownRewriterTests: XCTestCase {
    func test_GivenAMarkdownStringWithImages_ThenImagesAreRemovedFromText() {
        let textWithImage = "![my nice image](/public/assets/my-nice-image.png)"
        
        let textWithNoImages = MarkdownRewriter(text: textWithImage)
            .rewrite()
    
        XCTAssertEqual(textWithNoImages, "")
    }
}
