import Vapor
import Plot
import ReadingTime
import Foundation

let dateComponentsFormatter: DateComponentsFormatter = {
    var formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .abbreviated
    return formatter
}()

struct FormData: Codable {
    let content: String
}

func routes(_ app: Application) throws {
    app.post { request async throws -> Response in
        let formData = try request.content.decode(FormData.self)
        let readingTime = ReadingTime.calculate(for: formData.content)
        
        let queryParam: String
        if let readingTimeString = dateComponentsFormatter.string(from: readingTime) {
            queryParam = "?readingTime=\(readingTimeString)"
        } else {
            queryParam = ""
        }
        
        return request.redirect(to: "/\(queryParam)")
    }
    
    app.get { request async throws -> HTML in
        let readingTime = try? request.query.get(String.self, at: "readingTime")
        
        return HTML(
            .head(
                .title("Reading Time Playground!"),
                .stylesheet("https://unpkg.com/@picocss/pico@latest/css/pico.min.css"),
                .stylesheet("index.css")
            ),
            .body(
                .div(
                    .class("app"),
                    .h1(
                        "Reading Time Playground!"
                    ),
                    .form(
                        .method(.post),
                        .id("playground"),
                        .textarea(
                            .placeholder("Enter your markdown here!"),
                            .name("content"),
                            .attribute(named: "form", value: "playground")
                        ),
                        .if(readingTime != nil, .h3("Estimated Reading Time: \(readingTime ?? "")")),
                        .button(.type(.submit), "Calculate Reading Time!")
                    )
                )
            )
        )
    }
}
