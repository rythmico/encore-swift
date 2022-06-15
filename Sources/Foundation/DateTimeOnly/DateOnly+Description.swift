import Foundation

extension DateOnly: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(iso8601: description)
    }
}

extension DateOnly: CustomStringConvertible {
    public var description: String {
        self.formatted(style: .iso8601)
    }
}

extension DateOnly: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(year: \(year), month: \(month), day: \(day))"
    }
}
