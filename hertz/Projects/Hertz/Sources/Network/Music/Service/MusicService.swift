import Foundation

public final class MusicService: APIRequestLoader<MusicTarget> {
    
    public func getMusics() async -> NetworkResult<BaseResponse<[MusicResponse]>> {
        return await request(.musics, res: BaseResponse<[MusicResponse]>.self)
    }
    
    public func getMusic(id: Int) async -> NetworkResult<Data> {
        return await requestData(.music(id: id))
    }
}
