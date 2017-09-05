class AnotherClass: NSObject {

    func crash() {
        crash2()
    }

    func crash2() {
        makingAStackTrace() {
            let objC = AnObjCClass()
            objC.makeAStackTrace(self)
        }
    }

    func makingAStackTrace(_ block: () -> ()) {
        block()
    }

    func crash3() {
        preconditionFailure("This should NEVER happen")
    }
}
