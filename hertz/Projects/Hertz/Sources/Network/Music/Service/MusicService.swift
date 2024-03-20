import Foundation

public class MusicService {
    
    private init() {}
    
    public static let shared = MusicService()
    
    public func getMusics() async -> NetworkResult<BaseResponse<[MusicResponse]>> {
        return await HttpClient.shared.request(MusicTarget.musics, res: BaseResponse<[MusicResponse]>.self)
    }
    
    public func getMusic(id: Int) async -> NetworkResult<Data> {
        return await HttpClient.shared.requestData(MusicTarget.music(id: id))
    }
}
