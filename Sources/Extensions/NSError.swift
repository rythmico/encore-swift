import Foundation

extension NSError {
    public convenience init(
        domain: String? = nil,
        code: Int,
        localizedDescription: String
    ) {
        self.init(
            domain: domain ?? .empty,
            code: code,
            userInfo: [NSLocalizedDescriptionKey: localizedDescription]
        )
    }
}
