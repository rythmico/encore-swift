import Foundation

extension TimeOnly {
    public func formatted(style: DateFormatter.Style, locale: Locale) -> String {
        timeOnlyFormatter.locale = locale
        timeOnlyFormatter.timeStyle = style
        return timeOnlyFormatter.string(from: Date(self, in: timeZone))
    }

    public func formatted(custom: String, locale: Locale) -> String {
        timeOnlyFormatter.locale = locale
        timeOnlyFormatter.setLocalizedDateFormatFromTemplate(custom)
        return timeOnlyFormatter.string(from: Date(self, in: timeZone))
    }
}
