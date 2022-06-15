import Foundation

public struct TimeOnlyInterval: Hashable {
    public var start: TimeOnly
    public var end: TimeOnly

    public init(start: TimeOnly, end: TimeOnly) {
        self.start = start
        self.end = end
    }
}
