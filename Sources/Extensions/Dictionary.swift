extension Dictionary {
    public func compacted<Wrapped>() -> [Key: Wrapped] where Value == Wrapped? {
        compactMapValues { $0 }
    }
}
