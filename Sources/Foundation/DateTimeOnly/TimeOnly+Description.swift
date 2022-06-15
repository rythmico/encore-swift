import Foundation

extension TimeOnly: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(iso8601: description)
    }
}

extension TimeOnly: CustomStringConvertible {
    public var description: String {
        self.formatted(style: .iso8601)
    }
}

extension TimeOnly: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(hour: \(hour), minute: \(minute))"
    }
}
