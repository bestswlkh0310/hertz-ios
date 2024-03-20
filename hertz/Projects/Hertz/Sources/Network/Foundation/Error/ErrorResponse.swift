import Foundation

public struct ErrorResponse: Decodable {
    let status: Int
    let code: String
    let message: String
    
    public init(status: Int, code: String, message: String) {
        self.status = status
        self.code = code
        self.message = message
    }
}
