import Moya

public class UserService {
    
    private init() {}
    
    public static let shared = UserService()
    
    public func signUp(req: SignUpRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.signUp(req), res: BaseResponse<TokenResponse>.self)
    }
    
    public func signIn(req: SignInRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.signIn(req), res: BaseResponse<TokenResponse>.self)
    }
    
    public func refresh(refreshToken: String) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.refresh(refreshToken), res: BaseResponse<TokenResponse>.self)
    }
}
