import ArgumentParser
import Foundation
import ReadingTime

@main
struct ReadingTimeCLI: ParsableCommand {
    @Argument(help: "The path to a markdown file to be analysed. Relative to the executable.")
    var path: String
    
    func run() throws {
        let dateFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.minute, .second]
            return formatter
        }()
        
        guard let cwd = URL(string: FileManager.default.currentDirectoryPath),
              let data = FileManager.default.contents(atPath: "\(cwd.path)/\(path)"),
              let contents = String(data: data, encoding: .utf8) else {
                  throw "🛑 Could not get contents for file..."
              }
        
        let readingTime = ReadingTime.calculate(for: contents)
    
        if let formattedString = dateFormatter.string(from: readingTime) {
            print(formattedString)
        } else {
            print("\(readingTime) seconds")
        }
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
