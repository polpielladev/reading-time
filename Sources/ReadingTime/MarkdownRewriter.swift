import Markdown

struct Rewriter: MarkupRewriter {
    var imageCount = 0
    
    mutating func visitImage(_ image: Image) -> Markup? {
        imageCount += 1
        
        return nil
    }
}

public struct MarkdownRewriter {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public func rewrite() -> (String, Int) {
        let document = Document(parsing: text)
        var rewriter = Rewriter()
        let updatedDocument = rewriter.visitDocument(document)
        return (updatedDocument!.format(), rewriter.imageCount)
    }
}
