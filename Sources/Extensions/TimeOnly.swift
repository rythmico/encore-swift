import Foundation
import DateTimeOnly
import PeriodDuration

public enum TimeOnlyExtendedOperationError: LocalizedError {
    case cannotAddPeriod(TimeOnly, Period)
    case cannotAddDuration(TimeOnly, Duration)
    case cannotAddPeriodDuration(TimeOnly, PeriodDuration)

    public var errorDescription: String? {
        switch self {
        case .cannotAddPeriod(let dateOnly, let period):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Period: \(period)
            """
        case .cannotAddDuration(let dateOnly, let duration):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Duration: \(duration)
            """
        case .cannotAddPeriodDuration(let dateOnly, let periodDuration):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Period & Duration: \(periodDuration)
            """
        }
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: PeriodDuration) throws -> Self {
        guard let newDate = calendar.date(
            byAdding: rhs.asDateComponents,
            to: Date(lhs, in: timeZone),
            wrappingComponents: false
        ) else {
            throw TimeOnlyExtendedOperationError.cannotAddPeriodDuration(lhs, rhs)
        }
        return TimeOnly(newDate, in: timeZone)
    }

    public static func - (lhs: Self, rhs: PeriodDuration) throws -> Self {
        try lhs + -rhs
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: Period) throws -> Self {
        do {
            return try lhs + PeriodDuration(period: rhs)
        } catch is TimeOnlyExtendedOperationError {
            throw TimeOnlyExtendedOperationError.cannotAddPeriod(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Period) throws -> Self {
        try lhs + -rhs
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: Duration) throws -> Self {
        do {
            return try lhs + PeriodDuration(duration: rhs)
        } catch is TimeOnlyExtendedOperationError {
            throw TimeOnlyExtendedOperationError.cannotAddDuration(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Duration) throws -> Self {
        try lhs + -rhs
    }
}

private let locale = Locale.neutral
private let timeZone = TimeZone.neutral
private let calendar = Calendar.neutral
