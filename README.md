# ReadingTime

A small and light-weight package to get reading time information from a given markdown file. This is a tool made for writers that want to analyse the time it takes their readers to go through their articles.

## Installation

ReadingTime is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it and use it in your project, add it as a dependency within your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/pol-piella/reading-time.git", from: "1.0.0")
    ],
    ...
)
```

Then it's ready to be imported and used like so:

```swift
import ReadingTime
```
