import Foundation

extension DateOnlyInterval: CustomStringConvertible {
    public var description: String {
        start.formatted(style: .iso8601) + " - " + end.formatted(style: .iso8601)
    }
}

extension DateOnlyInterval: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(start: \(start), end: \(end))"
    }
}
