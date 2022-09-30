import JavaScriptKit
import Foundation
import ReadingTime

let document = JSObject.global.document

var button = document.createElement("button")
button.innerText = "Hello, world"
button.onclick = .object(JSClosure { _ in
    print(ReadingTime.calculate(for: "Hello World mate!!!"))
})
_ = document.body.appendChild(button)

_ = JSObject.global.alert!("Swift is running in the browser!")
