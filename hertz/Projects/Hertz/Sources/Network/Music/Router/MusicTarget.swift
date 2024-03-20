import Foundation
import Moya

public enum MusicTarget {
    case musics
    case music(id: Int)
}

extension MusicTarget: TargetType {
    public var baseURL: URL {
        Config.baseURL
    }
    
    public var path: String {
        switch self {
        case .musics:
            "\(ApiPath.musics)"
        case let .music(musicId):
            "\(ApiPath.musics)/\(musicId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .musics: 
                .get
        case .music(_): 
                .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .musics:
                .requestPlain
        case .music(_):
                .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        nil
    }
    
    public var validationType: ValidationType {
        switch self {
        case .musics:
                .successCodes
        case .music(_):
                .successCodes
        }
    }
}
