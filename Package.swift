// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "ReadingTime",
    platforms: [.iOS(.v8), .macOS(.v10_13)],
    products: [
        .library(
            name: "ReadingTime",
            targets: ["ReadingTime"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", branch: "main")
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
        .executableTarget(name: "ReadingTimeLambda", dependencies: [])
    ]
)
