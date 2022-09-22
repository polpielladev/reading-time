# ReadingTime

A small and light-weight package to get reading time information from a given **markdown file**. This is a tool made for writers that want to analyse the time it takes their readers to go through their articles.

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

## Usage

The API for ReadingTime is very simple. It consists of an enum called `ReadingTime` and two variants of a static method `calculate`. The calculation returns an estimate of the reading time for the provided markdown content in seconds.

It is important to note that the calculation does not count emojis as words, markdown images add a second each to the total reading time and that markdown links only count the words in the title and not the URL.

### Calculating reading time for a string

To calculate the reading time for a given string, use the `calculate(for content:wpm:)` method in `ReadingTime`. This takes in two parameters: the `String` to be parsed and the words per minute to use for the calculation. The latter defaults to `200`. 

```swift
let contents = "👋 Hello World! 🌍 This is my article! 🗞"
let calculatedTime = ReadingTime.calculate(for: contents) // Returns a TimeInterval type in seconds
```

### Calculating reading time for a file 

To calculate the reading time for a markdown file, use the `calculate(for file:wpm:)` method in `ReadingTime`. This takes in two parameters: the `URL` to the file that is to be parsed and the words per minute to use for the calculation. The latter defaults to `200`.

It is important tot note that the method can throw an error of type `ReadingTimeError`.

```swift
let fileURL = Bundle.module.url(forResource: "my-article", withExtension: "md")!
let calculatedTime = try ReadingTime.calculate(for: fileURL)
```

## Other notes

* 🤗 This package is completely open-source.
* 🐛 If you notice any bugs or have any feature requests please file an issue.
* ✍️ If you want to support me (the author of this package), feel free to follow me on [twitter](https://pol.link/twitter)! 
