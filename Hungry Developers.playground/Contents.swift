import UIKit

class Spoon {
    var index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    private let lock = NSLock()
    
    func pickUp() {
        self.lock.lock()
    }
    
    func putDown() {
        self.lock.unlock()
    }
}

class Developer {
    var name: String
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    
    func run() {
        while true {
            self.think()
            self.eat()
        }
    }
    
    func think() {
        let lowSpoon: Spoon
        let highSpoon: Spoon
        
        if leftSpoon.index < rightSpoon.index {
            lowSpoon = leftSpoon
            highSpoon = rightSpoon
        } else {
            lowSpoon = rightSpoon
            highSpoon = leftSpoon
        }
        
        lowSpoon.pickUp()
        highSpoon.pickUp()
        
        usleep(2)
    }
    
    func eat() {
        let randTime = UInt32.random(in: 1...10)
        usleep(randTime)
        print("\(self.name) started eating")
        self.leftSpoon.putDown()
        self.rightSpoon.putDown()
        print("\(self.name) finished eating")
    }
}

var spoon1 = Spoon(1)
var spoon2 = Spoon(2)
var spoon3 = Spoon(3)
var spoon4 = Spoon(4)
var spoon5 = Spoon(5)

let johhny = Developer(name: "Johhny", leftSpoon: spoon1, rightSpoon: spoon2)
let corey = Developer(name: "Corey", leftSpoon: spoon2, rightSpoon: spoon3)
let dongwoo = Developer(name: "Dongwoo", leftSpoon: spoon3, rightSpoon: spoon4)
let moin = Developer(name: "Moin", leftSpoon: spoon4, rightSpoon: spoon5)
let michael = Developer(name: "Michael", leftSpoon: spoon5, rightSpoon: spoon1)

var developers: [Developer] = [johhny, corey, dongwoo, moin, michael]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
