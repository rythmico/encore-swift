import Foundation

extension DateOnly {
    public static func now(in timeZone: TimeZone) -> Self {
        Self(DateTimeOnly.now(), in: timeZone)
    }
}
