import Foundation

public struct DateOnlyInterval: Hashable {
    public var start: DateOnly
    public var end: DateOnly

    public init(start: DateOnly, end: DateOnly) {
        self.start = start
        self.end = end
    }
}
