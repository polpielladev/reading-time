import Markdown

struct Rewriter: MarkupRewriter {
    mutating func visitImage(_ image: Image) -> Markup? {
        nil
    }
    
    func visitLink(_ link: Link) -> Markup? {
        guard let linkTitle = link.children.first(where: { $0 is Text }) else { return link }
        
        return linkTitle
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
