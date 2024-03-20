import Foundation

public struct SignInRequest: Encodable {
    let username: String
    let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
