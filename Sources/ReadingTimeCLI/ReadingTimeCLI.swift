import ArgumentParser
import Foundation
import ReadingTime

@main
struct ReadingTimeCLI: ParsableCommand {
    @Argument(help: "The path to a markdown file to be analysed. Relative to the executable.")
    var path: String
    
    func run() throws {
        guard let cwd = URL(string: FileManager.default.currentDirectoryPath),
              let data = FileManager.default.contents(atPath: "\(cwd.path)/\(path)"),
              let contents = String(data: data, encoding: .utf8) else {
                  throw "🛑 Could not get contents for file..."
              }
        
        let readingTime = ReadingTime.calculate(for: contents)
    
        if let formattedString = formattedString(from: readingTime) {
            print(formattedString)
        } else {
            print("\(readingTime) seconds")
        }
    }
    
    func formattedString(from timeInterval: TimeInterval) -> String? {
        #if !os(Linux)
        let dateFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.minute, .second]
            return formatter
        }()
        
        return dateFormatter.string(from: timeInterval)
        #else
        return nil
        #endif
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
