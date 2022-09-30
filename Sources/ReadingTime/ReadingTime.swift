import Foundation

public enum ReadingTimeError: Error {
    case fileNotFound
    case fileCouldNotBeDecoded
}

public enum ReadingTime {
    public static func calculate(for content: String, wpm: Int = 200) -> TimeInterval {
        #if !arch(wasm32)
        let rewrittenMarkdown = MarkdownRewriter(text: content)
            .rewrite()
        #else
        let rewrittenMarkdown = content
        #endif
        let contentWithoutEmojis = rewrittenMarkdown.removingEmoji
        let timeIntervalInMinutes = Double(count(wordsIn: contentWithoutEmojis)) / Double(wpm)
        let timeIntervalInSeconds = timeIntervalInMinutes * 60
        
        return round(timeIntervalInSeconds)
    }
    
    #if !arch(wasm32)
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
    #endif
    
    #if !os(Linux) && !arch(wasm32)
    private static func count(wordsIn string: String) -> Int {
        var count = 0
        let range = string.startIndex..<string.endIndex
        string.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        return count
    }
    #else
    private static func count(wordsIn string: String) -> Int {
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let components = string.components(separatedBy: chararacterSet)
        let words = components.filter { !$0.isEmpty }
        
        return words.count
    }
    #endif
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
