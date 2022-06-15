import Foundation

extension DateOnly {
    public func formatted(style: DateFormatter.Style, locale: Locale) -> String {
        dateOnlyFormatter.locale = locale
        dateOnlyFormatter.dateStyle = style
        return dateOnlyFormatter.string(from: Date(self, in: timeZone))
    }

    public func formatted(custom: String, locale: Locale) -> String {
        dateOnlyFormatter.locale = locale
        dateOnlyFormatter.setLocalizedDateFormatFromTemplate(custom)
        return dateOnlyFormatter.string(from: Date(self, in: timeZone))
    }
}
