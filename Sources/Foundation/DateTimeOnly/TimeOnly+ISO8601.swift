import Foundation

extension TimeOnly {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension TimeOnly {
    public init?(iso8601 rawValue: String) {
        guard let date = Self.formatter.date(from: rawValue) else {
            return nil
        }
        self = TimeOnly(date, in: timeZone)
    }

    public func formatted(style: StandardFormatStyle) -> String {
        var dateComponents = DateComponents(self)
        dateComponents.calendar = calendar()
        dateComponents.timeZone = timeZone
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        return Self.formatter.string(from: date)
    }

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }()
}
