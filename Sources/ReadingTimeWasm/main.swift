import JavaScriptKit
import ReadingTime

let document = JSObject.global.document

var readingTimeButton = document.querySelector("#reading-time-calculate")

readingTimeButton.onclick = .object(JSClosure { _ in
    let document = JSObject.global.document
    let element = document.querySelector("#reading-time-content")
    let text = element.value.string
    print(ReadingTime.calculate(for: text ?? ""))
    return .null
})
