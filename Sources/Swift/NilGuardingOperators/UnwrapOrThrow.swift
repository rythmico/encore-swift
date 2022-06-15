infix operator ?! : NilCoalescingPrecedence

public func ?! <T>(optional: T?, error: @autoclosure () -> Error) throws -> T {
    try optional ?! error
}

public func ?! <T>(optional: T?, error: () -> Error) throws -> T {
    guard let value = optional else {
        throw error()
    }
    return value
}
