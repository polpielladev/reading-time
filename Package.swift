// swift-tools-version: 5.6
import PackageDescription

var targets: [Target] = [
    .target(
        name: "ReadingTime",
        dependencies: [.product(name: "Markdown", package: "swift-markdown-wasm")]),
    .testTarget(
        name: "ReadingTimeTests",
        dependencies: ["ReadingTime"],
        resources: [.copy("MockData")]
    ),
]

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/pol-piella/swift-markdown-wasm.git", branch: "release/5.7"),
]

#if !arch(wasm32)
targets.append(contentsOf: [
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
])

dependencies.append(contentsOf: [
    .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", from: "0.1.0"),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/JohnSundell/Plot.git", from: "0.5.0")
])
#endif

let package = Package(
    name: "ReadingTime",
    platforms: [.iOS(.v11), .macOS(.v12)],
    products: [
        .library(
            name: "ReadingTime",
            targets: ["ReadingTime"]),
    ],
    dependencies: dependencies,
    targets: targets
)
