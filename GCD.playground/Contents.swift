


import Foundation

// cancel workItem task
var item: DispatchWorkItem!
let globalQueue = DispatchQueue.global(qos: .background)

item = DispatchWorkItem {
    while true {
        print("0")
        if item.isCancelled {
            break
        }
    }
}

globalQueue.async(execute: item)

globalQueue.asyncAfter(deadline: DispatchTime.now() + 2.0) {
    item.cancel()
}

// Deadlock task
let firstQueue = DispatchQueue(
    label: "com.gcd.firstQueue"
)

let secondQueue = DispatchQueue(
    label: "com.gcd.secondQueue"
)

firstQueue.async {
    print("1")
    secondQueue.sync {
        print("2")
        firstQueue.sync {
            print("3")
        }
        print("4")
    }
    print("5")
}
