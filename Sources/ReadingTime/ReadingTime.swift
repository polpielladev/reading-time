import Foundation

public enum ReadingTimeError: Error {
    case fileNotFound
    case fileCouldNotBeDecoded
}

public enum ReadingTime {
    public static func calculate(for content: String, wpm: Int = 265) -> TimeInterval {
        let characterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = content.components(separatedBy: characterSet)
        let words = components.filter { !$0.isEmpty }
        let timeIntervalInMinutes = Double(words.count) / Double(wpm)
        let timeIntervalInMilliseconds = timeIntervalInMinutes * 60 * 1000
        
        return round(timeIntervalInMilliseconds * 100) / 100.0
    }
    
    public static func calculate(for file: URL, wpm: Int = 265) throws -> TimeInterval {
        if !FileManager.default.fileExists(atPath: file.path) {
            throw ReadingTimeError.fileNotFound
        }
        
        guard let contentsOfFile = FileManager.default.contents(atPath: file.path),
              let string = String(data: contentsOfFile, encoding: .utf8) else {
            throw ReadingTimeError.fileCouldNotBeDecoded
        }
        
        
        return Self.calculate(for: string, wpm: wpm)
    }
}
