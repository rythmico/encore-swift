import Foundation

public enum TimeOnlyOperationError: LocalizedError {
    case cannotAdd(TimeOnly, amount: Int, unit: Calendar.Component)
    case cannotDiff(minuend: TimeOnly, subtrahend: TimeOnly, unit: Calendar.Component)

    public var errorDescription: String? {
        switch self {
        case .cannotAdd(let timeOnly, let amount, let unit):
            return """
            Time addition failed:
            - Time Only: \(timeOnly)
            - Amount: \(amount)
            - Unit: \(unit)
            """
        case .cannotDiff(let minuend, let subtrahend, let unit):
            return """
            Time Only diff failed:
            - Minuend: \(minuend)
            - Subtrahend: \(subtrahend)
            - Unit: \(unit)
            """
        }
    }
}

// MARK: Add

extension TimeOnly {
    public mutating func add(_ amount: Int, _ unit: Calendar.Component) throws {
        guard let newDate = calendar().date(
            byAdding: unit,
            value: amount,
            to: Date(self, in: timeZone),
            wrappingComponents: false
        ) else {
            throw TimeOnlyOperationError.cannotAdd(self, amount: amount, unit: unit)
        }
        self = TimeOnly(newDate, in: timeZone)
    }

    public func adding(_ amount: Int, _ unit: Calendar.Component) throws -> Self {
        var _self = self
        try _self.add(amount, unit)
        return _self
    }

    public static func + (lhs: Self, rhs: (amount: Int, unit: Calendar.Component)) throws -> Self {
        try lhs.adding(rhs.amount, rhs.unit)
    }
}

// MARK: Subtract

extension TimeOnly {
    public mutating func subtract(_ amount: Int, _ unit: Calendar.Component) throws {
        try self.add(-amount, unit)
    }

    public func subtracting(_ amount: Int, _ unit: Calendar.Component) throws -> Self {
        try self.adding(-amount, unit)
    }

    public static func - (lhs: Self, rhs: (amount: Int, unit: Calendar.Component)) throws -> Self {
        try lhs + (-rhs.amount, rhs.unit)
    }
}

// MARK: Diff

extension TimeOnly {
    public static func diff(from minuend: Self, to subtrahend: Self, _ unit: Calendar.Component) throws -> Int {
        guard
            let diffResult = calendar().dateComponents(
                [unit],
                from: DateComponents(subtrahend),
                to: DateComponents(minuend)
            ).value(for: unit)
        else {
            throw TimeOnlyOperationError.cannotDiff(minuend: minuend, subtrahend: subtrahend, unit: unit)
        }
        return diffResult
    }

    public func diffing(_ subtrahend: Self, _ unit: Calendar.Component) throws -> Int {
        try Self.diff(from: self, to: subtrahend, unit)
    }

    public static func - (lhs: Self, rhs: (other: Self, unit: Calendar.Component)) throws -> Int {
        try lhs.diffing(rhs.other, rhs.unit)
    }
}
