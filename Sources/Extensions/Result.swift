extension Result {
    public init?(value: Success?, error: Failure?) {
        switch (value, error) {
        case (let value?, _):
            self = .success(value)
        case (_, let error?):
            self = .failure(error)
        case (nil, nil):
            return nil
        }
    }
}

extension Result {
    public var value: Success? {
        guard case .success(let value) = self else { return nil }
        return value
    }

    public var error: Failure? {
        guard case .failure(let error) = self else { return nil }
        return error
    }
}

extension Result {
    public var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    public var isFailure: Bool {
        guard case .failure = self else { return false }
        return true
    }
}

extension Result where Success == Void {
    public static var success: Result { .success(()) }
}

extension Result {
    public func eraseError() -> Result<Success, Error> {
        mapError { $0 as Error }
    }
}
