infix operator !! : NilCoalescingPrecedence

public func !! <T>(optional: T?, exit: @autoclosure () -> Never) -> T {
    optional !! exit
}

public func !! <T>(optional: T?, exit: () -> Never) -> T {
    guard let value = optional else {
        exit()
    }
    return value
}
