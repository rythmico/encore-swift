public typealias Action = () -> Void
public typealias Handler<T> = (T) -> Void // TODO: use variadic generics when available
public typealias ResultHandler<Success, Failure: Error> = Handler<Result<Success, Failure>>
