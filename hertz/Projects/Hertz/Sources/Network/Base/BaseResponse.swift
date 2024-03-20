import Foundation

public struct BaseResponse<Data: Decodable>: Decodable {
    let status: Int
    let message: String
    let data: Data
}
