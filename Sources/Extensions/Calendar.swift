import Foundation

extension Calendar {
    public static var neutral: Self {
        Calendar(identifier: .gregorian, locale: .neutral, timeZone: .neutral)
    }

    public init(identifier: Identifier, locale: Locale, timeZone: TimeZone) {
        self.init(identifier: identifier)
        self.locale = locale
        self.timeZone = timeZone
    }
}
