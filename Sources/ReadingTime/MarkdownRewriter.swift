import Markdown

struct Rewriter: MarkupRewriter {
    func visitImage(_ image: Image) -> Markup? {
        return nil
    }
}

public struct MarkdownRewriter {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public func rewrite() -> String {
        let document = Document(parsing: text)
        var rewriter = Rewriter()
        let updatedDocument = rewriter.visitDocument(document)
        return updatedDocument!.format()
    }
}
