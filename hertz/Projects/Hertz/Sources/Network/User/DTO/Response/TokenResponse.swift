import Foundation

public struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
