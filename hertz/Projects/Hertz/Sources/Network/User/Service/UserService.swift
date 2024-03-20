import Moya

class UserService {
    
    func signUp(req: SignUpRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.signUp(req), res: BaseResponse<TokenResponse>.self)
    }
    
    func signIn(req: SignInRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.signIn(req), res: BaseResponse<TokenResponse>.self)
    }
    
    func refresh(refreshToken: String) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await HttpClient.shared.request(UserTarget.refresh(refreshToken), res: BaseResponse<TokenResponse>.self)
    }
}
