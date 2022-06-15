import Foundation

extension TimeOnly {
    public static func now(in timeZone: TimeZone) -> Self {
        Self(DateTimeOnly.now(), in: timeZone)
    }
}
