import Do
import Foundation
import NilGuardingOperators

extension Date {
    #if os(Linux)
    public static var now: Date {
        Date()
    }
    #endif

    public static var referenceDate: Date {
        Date(timeIntervalSinceReferenceDate: .zero)
    }
}

public enum DateOperationError: LocalizedError {
    case cannotMutate(Date, newComponents: DateComponents, TimeZone)
    case cannotAdd(Date, amount: Int, unit: Calendar.Component, TimeZone)
    case cannotDiff(minuend: Date, subtrahend: Date, unit: Calendar.Component, TimeZone)

    public var errorDescription: String? {
        switch self {
        case .cannotMutate(let date, let components, let timeZone):
            return """
            Date mutation failed:
            - Date: \(date)
            - New Components: \(components)
            - Time Zone: \(timeZone)
            """
        case .cannotAdd(let date, let amount, let unit, let timeZone):
            return """
            Date addition failed:
            - Date: \(date)
            - Amount: \(amount)
            - Unit: \(unit)
            - Time Zone: \(timeZone)
            """
        case .cannotDiff(let minuend, let subtrahend, let unit, let timeZone):
            return """
            Date diff failed:
            - Minuend: \(minuend)
            - Subtrahend: \(subtrahend)
            - Unit: \(unit)
            - Time Zone: \(timeZone)
            """
        }
    }
}

// TODO: typed throws (when available)

extension Date {
    public static func => (lhs: Date, rhs: (set: Set<Calendar.Component>, to: Int, for: TimeZone)) throws -> Date {
        let (units, amount, timeZone) = rhs
        return try lhs.setting(
            units.reduce(into: DateComponents()) { $0.setValue(amount, for: $1) },
            for: timeZone
        )
    }

    public static func => (lhs: Date, rhs: (set: Calendar.Component, to: Int, for: TimeZone)) throws -> Date {
        try lhs => (set: [rhs.set], to: rhs.to, for: rhs.for)
    }

    private func setting(_ components: DateComponents, for timeZone: TimeZone) throws -> Date {
        let calendar = Self.calendar(for: timeZone)
        let allUnits: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let originalComponents = calendar.dateComponents(allUnits, from: self)
        let newComponents = allUnits.reduce(into: originalComponents) { acc, unit in
            acc.setValue(components.optionalValue(for: unit) ?? acc.optionalValue(for: unit), for: unit)
        }
        return try calendar.date(from: newComponents) ?! DateOperationError.cannotMutate(self, newComponents: components, timeZone)
    }

    private static func calendar(for timeZone: TimeZone) -> Calendar {
        baseCalendar => (\.timeZone, timeZone)
    }

    private static let baseCalendar = Calendar.neutral
}

extension Date {
    public static func + (lhs: Date, rhs: (amount: Int, unit: Calendar.Component, timeZone: TimeZone)) throws -> Date {
        try Self.calendar(for: rhs.timeZone).date(byAdding: rhs.unit, value: rhs.amount, to: lhs) ?! {
            DateOperationError.cannotAdd(lhs, amount: rhs.amount, unit: rhs.unit, rhs.timeZone)
        }
    }

    public static func - (lhs: Date, rhs: (amount: Int, unit: Calendar.Component, timeZone: TimeZone)) throws -> Date {
        try lhs + (-rhs.amount, rhs.unit, rhs.timeZone)
    }

    public static func - (lhs: Date, rhs: (date: Date, unit: Calendar.Component, timeZone: TimeZone)) throws -> Int {
        try Self.calendar(for: rhs.timeZone).dateComponents([rhs.unit], from: rhs.date, to: lhs).value(for: rhs.unit) ?! {
            DateOperationError.cannotDiff(minuend: lhs, subtrahend: rhs.date, unit: rhs.unit, rhs.timeZone)
        }
    }
}

extension DateComponents {
    public func optionalValue(for unit: Calendar.Component) -> Int? {
        guard let value = value(for: unit), value != NSNotFound else {
            return nil
        }
        return value
    }
}

#if DEBUG
extension Date: ExpressibleByStringLiteral {
    private static let _iso8601Formatter = ISO8601DateFormatter()

    public init(stringLiteral value: StringLiteralType) {
        self = Self._iso8601Formatter.date(from: value) !! {
            preconditionFailure("Could not parse string literal '\(value)' into ISO 8601 date")
        }
    }
}
#endif
