// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "ReadingTime",
    platforms: [.iOS(.v8), .macOS(.v12)],
    products: [
        .library(
            name: "ReadingTime",
            targets: ["ReadingTime"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", branch: "main"),
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/JohnSundell/Plot.git", from: "0.5.0"),
        .package(url: "https://github.com/danger/swift.git", from: "3.12.1"),
    ],
    targets: [
        .target(
            name: "ReadingTime",
            dependencies: [.product(name: "Markdown", package: "swift-markdown")]),
        .testTarget(
            name: "ReadingTimeTests",
            dependencies: ["ReadingTime"],
            resources: [.copy("MockData")]
        ),
        .target(name: "DangerDeps", dependencies: [.product(name: "Danger", package: "swift")]),
        .executableTarget(name: "ReadingTimeLambda", dependencies: [
            .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
            .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
            "ReadingTime"
        ]),
        .target(
            name: "ReadingTimeSite",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Plot", package: "plot"),
                "ReadingTime"
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(
            name: "ReadingTimeSiteRunner",
            dependencies: ["ReadingTimeSite"]
        )
    ]
)
