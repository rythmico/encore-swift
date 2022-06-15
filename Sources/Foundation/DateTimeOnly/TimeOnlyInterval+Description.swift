import Foundation

extension TimeOnlyInterval: CustomStringConvertible {
    public var description: String {
        start.formatted(style: .iso8601) + " - " + end.formatted(style: .iso8601)
    }
}

extension TimeOnlyInterval: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(start: \(start), end: \(end))"
    }
}
