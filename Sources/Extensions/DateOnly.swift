import Foundation
import DateTimeOnly
import PeriodDuration

public enum DateOnlyExtendedOperationError: LocalizedError {
    case cannotAddPeriod(DateOnly, Period)
    case cannotAddDuration(DateOnly, Duration)
    case cannotAddPeriodDuration(DateOnly, PeriodDuration)

    public var errorDescription: String? {
        switch self {
        case .cannotAddPeriod(let dateOnly, let period):
            return """
            Date addition failed:
            - Date Only: \(dateOnly)
            - Period: \(period)
            """
        case .cannotAddDuration(let dateOnly, let duration):
            return """
            Date addition failed:
            - Date Only: \(dateOnly)
            - Duration: \(duration)
            """
        case .cannotAddPeriodDuration(let dateOnly, let periodDuration):
            return """
            Date addition failed:
            - Date Only: \(dateOnly)
            - Period & Duration: \(periodDuration)
            """
        }
    }
}

extension DateOnly {
    public static func + (lhs: Self, rhs: PeriodDuration) throws -> Self {
        guard let newDate = calendar.date(
            byAdding: rhs.asDateComponents,
            to: Date(lhs, in: timeZone),
            wrappingComponents: false
        ) else {
            throw DateOnlyExtendedOperationError.cannotAddPeriodDuration(lhs, rhs)
        }
        return DateOnly(newDate, in: timeZone)
    }

    public static func - (lhs: Self, rhs: PeriodDuration) throws -> Self {
        try lhs + -rhs
    }
}

extension DateOnly {
    public static func + (lhs: Self, rhs: Period) throws -> Self {
        do {
            return try lhs + PeriodDuration(period: rhs)
        } catch is DateOnlyExtendedOperationError {
            throw DateOnlyExtendedOperationError.cannotAddPeriod(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Period) throws -> Self {
        try lhs + -rhs
    }
}

extension DateOnly {
    public static func + (lhs: Self, rhs: Duration) throws -> Self {
        do {
            return try lhs + PeriodDuration(duration: rhs)
        } catch is DateOnlyExtendedOperationError {
            throw DateOnlyExtendedOperationError.cannotAddDuration(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Duration) throws -> Self {
        try lhs + -rhs
    }
}

private let locale = Locale.neutral
private let timeZone = TimeZone.neutral
private let calendar = Calendar.neutral
