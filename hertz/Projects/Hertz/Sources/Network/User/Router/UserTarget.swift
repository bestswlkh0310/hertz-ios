import Moya
import Foundation

public enum UserTarget {
    case signUp(_ req: SignUpRequest)
    case signIn(_ req: SignInRequest)
    case refresh(_ refreshToken: String)
}

extension UserTarget: TargetType {
    public var baseURL: URL {
        Config.baseURL
    }
    
    public var path: String {
        switch self {
        case .signUp:
            "\(ApiPath.users)/sign-up"
        case .signIn:
            "\(ApiPath.users)/sign-in"
        case .refresh:
            "\(ApiPath.users)/refresh"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .signUp:
                .post
        case .signIn:
                .post
        case .refresh:
                .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .signUp(req):
                .requestJSONEncodable(req)
        case let .signIn(req):
                .requestJSONEncodable(req)
        case let .refresh(req):
                .requestJSONEncodable(req)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signUp(_):
            nil
        case .signIn(_):
            nil
        case let .refresh(refreshToken):
            [
                "refresh-token": refreshToken
            ]
        }
    }
    
    public var authorization: Authorization {
        switch self {
        case .signUp(_):
                .unauthorization
        case .signIn(_):
                .unauthorization
        case .refresh(_):
                .unauthorization
        }
    }
    
    
}
