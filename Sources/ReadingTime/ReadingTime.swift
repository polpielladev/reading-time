import Foundation

public enum ReadingTimeError: Error {
    case fileNotFound
    case fileCouldNotBeDecoded
}

public enum ReadingTime {
    public static func calculate(for content: String, wpm: Int = 200) -> TimeInterval {
        let rewrittenMarkdown = MarkdownRewriter(text: content)
            .rewrite()
        let characterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let contentWithoutEmojis = rewrittenMarkdown.removingEmoji
        let components = contentWithoutEmojis.components(separatedBy: characterSet)
        let words = components.filter { !$0.isEmpty }
        let timeIntervalInMinutes = Double(words.count) / Double(wpm)
        let timeIntervalInMilliseconds = timeIntervalInMinutes * 60 * 1000
        
        return round(timeIntervalInMilliseconds * 100) / 100.0
    }
    
    public static func calculate(for file: URL, wpm: Int = 200) throws -> TimeInterval {
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

// Some useful extensions to deal with removing emojis 🔝
// https://stackoverflow.com/a/68853348
extension Character {
    var isEmoji: Bool { unicodeScalars.first?.properties.isEmoji == true && !isDigit }
    var isDigit: Bool { "0"..."9" ~= self }
    var isNotEmoji: Bool { !isEmoji }
}

extension RangeReplaceableCollection where Self: StringProtocol {
    var removingEmoji: Self  { filter(\.isNotEmoji) }
    var emojis: Self  { filter(\.isEmoji) }
}
