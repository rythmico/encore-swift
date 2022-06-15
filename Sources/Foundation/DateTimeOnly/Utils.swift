import Foundation

#if DEBUG // check for XCTests running instead, if it ever becomes possible...
var now: () -> Date = { Date() }
#else
let now: () -> Date = { Date() }
#endif
let locale = Locale(identifier: "en_US_POSIX")
let timeZone = TimeZone(secondsFromGMT: .zero)!
func calendar() -> Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = locale
    calendar.timeZone = timeZone
    return calendar
}
let dateOnlyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar()
    return formatter
}()
let timeOnlyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar()
    return formatter
}()
let dateOnlyIntervalFormatter: DateIntervalFormatter = {
    let formatter = DateIntervalFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar()
    formatter.timeStyle = .none
    return formatter
}()
let timeOnlyIntervalFormatter: DateIntervalFormatter = {
    let formatter = DateIntervalFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar()
    formatter.dateStyle = .none
    return formatter
}()
