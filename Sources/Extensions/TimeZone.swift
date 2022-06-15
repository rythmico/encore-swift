import Foundation
import NilGuardingOperators
import Tagged

extension TimeZone {
    public static var neutral: Self {
        TimeZone(secondsFromGMT: .zero) !! {
            preconditionFailure("TimeZone.init(secondsFromGMT: .zero) returned nil")
        }
    }
}

extension TimeZone {
    public typealias ID = Tagged<Self, String>

    public init?(id: ID) {
        self.init(identifier: id.rawValue)
    }

    public var id: ID {
        ID(rawValue: identifier)
    }
}
