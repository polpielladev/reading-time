import AWSLambdaRuntime
import Foundation
import ReadingTime
import AWSLambdaEvents

private struct Request: Codable {
    let content: String
}

private struct Response: Codable {
    let time: TimeInterval
}

extension JSONEncoder {
    func encodeAsString<T: Encodable>(_ value: T) throws -> String {
        try String(decoding: self.encode(value), as: Unicode.UTF8.self)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        try self.decode(type, from: Data(string.utf8))
    }
}

let jsonEncoder = JSONEncoder()
let jsonDecoder = JSONDecoder()

Lambda.run { (context, request: APIGateway.V2.Request, callback: @escaping (Result<APIGateway.V2.Response, Error>) -> Void) in
    guard request.context.http.method == .POST, request.context.http.path == "/calculate" else {
        return callback(.success(APIGateway.V2.Response(statusCode: .notFound)))
    }
    
    do {
        let request = try jsonDecoder.decode(Request.self, from: request.body ?? "")
        let readingTime = ReadingTime.calculate(for: request.content)
        let body = try jsonEncoder.encodeAsString(Response(time: readingTime))
        callback(.success(APIGateway.V2.Response(
            statusCode: .ok,
            headers: ["content-type": "application/json"],
            body: body
        )))
    } catch {
        print(error.localizedDescription)
        callback(.success(APIGateway.V2.Response(statusCode: .badRequest)))
    }
}
