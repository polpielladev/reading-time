import Vapor
import Plot

func routes(_ app: Application) throws {
    app.get { request async throws -> HTML in
        HTML(
            .body(
                .h1("Hello World")
            )
        )
    }
}
