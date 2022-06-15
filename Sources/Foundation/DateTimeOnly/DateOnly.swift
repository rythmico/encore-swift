import Foundation

/// Defines the components of a date, without any information about the time.
///
/// This struct is meant as a subset of `DateComponents` with only year, month, and day.
public struct DateOnly: Hashable {
    public private(set) var year: Int
    public private(set) var month: Int
    public private(set) var day: Int

    public init(year: Int, month: Int, day: Int) throws {
        guard year > 0, month > 0, day > 0 else {
            throw DateOnlyInitError.invalidDateComponents(year: year, month: month, day: day)
        }
        let components = DateComponents(
            calendar: calendar(),
            timeZone: timeZone,
            year: year,
            month: month,
            day: day
        )
        guard let date = components.date else {
            throw DateOnlyInitError.invalidDateComponents(year: year, month: month, day: day)
        }
        self.init(date, in: timeZone)
    }
}

public enum DateOnlyInitError: LocalizedError {
    case invalidDateComponents(year: Int, month: Int, day: Int)

    public var errorDescription: String? {
        switch self {
        case .invalidDateComponents(let year, let month, let day):
            return """
            Date Only init failed:
            - Year: \(year)
            - Month: \(month)
            - Day: \(day)
            """
        }
    }
}

extension DateOnly {
    public init(_ date: Date, in timeZone: TimeZone) {
        let dateComponents = calendar().dateComponents(in: timeZone, from: date)
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day
        else {
            preconditionFailure("calendar.dateComponents(in:from:) is always guaranteed to return all date components")
        }
        self.year = year
        self.month = month
        self.day = day
    }
}
