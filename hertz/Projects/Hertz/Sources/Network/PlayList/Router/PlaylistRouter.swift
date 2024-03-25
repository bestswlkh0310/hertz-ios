import Moya
import Foundation


enum PlaylistTarget {
    case playlists
}

extension PlaylistTarget: TargetType {
    var baseURL: URL {
        Config.baseURL
    }
    
    var path: String {
        switch self {
        case .playlists: "\(ApiPath.playlists)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .playlists: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .playlists: .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
