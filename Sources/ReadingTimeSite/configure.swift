import Vapor

// configures your application
public func configure(_ app: Application) throws {
     app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
}
