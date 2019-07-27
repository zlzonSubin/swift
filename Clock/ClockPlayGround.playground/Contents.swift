import UIKit

var str = "Hello, playground"

let date = Date()
date.debugDescription

Date.distantFuture

let form = DateFormatter()

form.timeStyle = .short

let stringDate = form.string(from: date)



