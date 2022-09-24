import Vapor
import Plot
import ReadingTime

let dateComponentsFormatter: DateComponentsFormatter = {
    var formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .abbreviated
    return formatter
}()

func routes(_ app: Application) throws {
    app.get { request async throws -> HTML in
        let content = try? request.query.get(String.self, at: "content")
        var readingTime: String? = nil
        if let content = content {
            let calculation = ReadingTime.calculate(for: content)
            readingTime = dateComponentsFormatter.string(from: calculation)
        }
        
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
                        .id("playground"),
                        .textarea(
                            "\(content ?? "")",
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
