import Foundation

extension Date {
    public init(date: DateOnly, time: TimeOnly, in timeZone: TimeZone) {
        var calendar = calendar()
        calendar.timeZone = timeZone
        var dateComponents = DateComponents(date: date, time: time)
        dateComponents.calendar = calendar
        dateComponents.timeZone = timeZone
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        self = date
    }
}

extension DateComponents {
    public init(date: DateOnly, time: TimeOnly) {
        self.init(
            year: date.year,
            month: date.month,
            day: date.day,
            hour: time.hour,
            minute: time.minute
        )
    }
}
