import Foundation

class MusicAPI {
    
    static let session = URLSession.shared
    static let decoder = JSONDecoder()
    
    static func getMusics() async throws -> [Music] {
        let url = URL(string: "\(Constant.baseUrl)/musics")!
        let (data, _) = try await session.data(from: url)
        let response = try decoder.decode([MusicResponse].self, from: data)
        return response.map { $0.toDomain() }
    }
    
    static func getMusic(id: Int) async throws -> Data {
        let url = URL(string: "\(Constant.baseUrl)/music/\(id)")!
        let (data, _) = try await session.data(from: url)
        return data
    }
}
