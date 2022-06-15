import Foundation

/// Defines the components of a time, without any information about the date.
///
/// This struct is meant as a subset of `DateComponents` with only hour and minute.
public struct TimeOnly: Hashable {
    public private(set) var hour: Int
    public private(set) var minute: Int

    public init(hour: Int, minute: Int) throws {
        guard hour >= 0, minute >= 0 else {
            throw TimeOnlyInitError.invalidDateComponents(hour: hour, minute: minute)
        }
        let components = DateComponents(
            calendar: calendar(),
            timeZone: timeZone,
            hour: hour,
            minute: minute
        )
        guard let date = components.date else {
            throw TimeOnlyInitError.invalidDateComponents(hour: hour, minute: minute)
        }
        self.init(date, in: timeZone)
    }
}

public enum TimeOnlyInitError: LocalizedError {
    case invalidDateComponents(hour: Int, minute: Int)

    public var errorDescription: String? {
        switch self {
        case .invalidDateComponents(let hour, let minute):
            return """
            Time Only init failed:
            - Hour: \(hour)
            - Minute: \(minute)
            """
        }
    }
}

extension TimeOnly {
    public init(_ date: Date, in timeZone: TimeZone) {
        let dateComponents = calendar().dateComponents(in: timeZone, from: date)
        guard
            let hour = dateComponents.hour,
            let minute = dateComponents.minute
        else {
            preconditionFailure("calendar.dateComponents(in:from:) is always guaranteed to return all date components")
        }
        self.hour = hour
        self.minute = minute
    }
}
