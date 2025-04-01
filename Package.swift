// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "ReadingTime",
    platforms: [.iOS(.v15), .macOS(.v12), .macCatalyst(.v15)],
    products: [
        .library(
            name: "ReadingTime",
            targets: ["ReadingTime"]),
        .executable(
            name: "ReadingTimeCLI",
            targets: ["ReadingTimeCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-markdown.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4")
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
        .executableTarget(
            name: "ReadingTimeCLI",
            dependencies: ["ReadingTime", .product(name: "ArgumentParser", package: "swift-argument-parser")]
        )
    ]
)
