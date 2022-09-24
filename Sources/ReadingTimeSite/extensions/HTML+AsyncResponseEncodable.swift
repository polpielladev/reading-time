import Plot
import Vapor

extension HTML: AsyncResponseEncodable {
    public func encodeResponse(for request: Request) async throws -> HTML {
        return self
    }
    
    public func encodeResponse(for request: Request) async throws -> Response {
        Response(headers: ["content-type": "text/html; charset=utf-8"], body: .init(string: self.render()))
    }
}
