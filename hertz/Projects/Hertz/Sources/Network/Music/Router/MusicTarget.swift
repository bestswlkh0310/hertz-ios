import Foundation
import Moya

enum MusicTarget {
    case musics
    case music(id: Int)
}

extension MusicTarget: TargetType {
    var baseURL: URL {
        Config.baseURL
    }
    
    var path: String {
        switch self {
        case .musics:
            "\(ApiPath.musics)"
        case let .music(musicId):
            "\(ApiPath.musics)/\(musicId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .musics: 
                .get
        case .music(_): 
                .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .musics:
                .requestPlain
        case .music(_):
                .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var validationType: ValidationType {
        switch self {
        case .musics:
                .successCodes
        case .music(_):
                .successCodes
        }
    }
}
