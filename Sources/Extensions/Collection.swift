extension Collection {
    public var nilIfEmpty: Self? {
        isEmpty ? nil : self
    }
}

extension Collection {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0 else { return nil }
        return dropFirst(index).first
    }
}

extension RangeReplaceableCollection {
    public func appending(_ element: Element) -> Self {
        var copy = self
        copy.append(element)
        return copy
    }

    public static func + (lhs: Self, rhs: Element) -> Self {
        lhs.appending(rhs)
    }
}

extension RangeReplaceableCollection where Element: Equatable {
    public mutating func removeAll(of element: Element) {
        removeAll(where: { $0 == element })
    }

    public func removingAll(of element: Element) -> Self {
        var copy = self
        copy.removeAll(of: element)
        return copy
    }
}
