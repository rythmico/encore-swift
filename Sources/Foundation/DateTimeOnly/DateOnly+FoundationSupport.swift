import Foundation

extension Date {
    public init(_ dateOnly: DateOnly, in timeZone: TimeZone) {
        var calendar = calendar()
        calendar.timeZone = timeZone
        var dateComponents = DateComponents(dateOnly)
        dateComponents.calendar = calendar
        dateComponents.timeZone = timeZone
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        self = date
    }
}

extension DateOnly {
    public var asDateComponents: DateComponents {
        DateComponents(self)
    }
}

extension DateComponents {
    public init(_ dateOnly: DateOnly) {
        self.init(
            year: dateOnly.year,
            month: dateOnly.month,
            day: dateOnly.day
        )
    }
}
