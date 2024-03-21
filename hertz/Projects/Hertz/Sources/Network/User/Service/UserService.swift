import Moya

public class UserService: APIRequestLoader<UserTarget> {
    
    public func signUp(req: SignUpRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await request(.signUp(req), res: BaseResponse<TokenResponse>.self)
    }
    
    public func signIn(req: SignInRequest) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await request(.signIn(req), res: BaseResponse<TokenResponse>.self)
    }
    
    public func refresh(refreshToken: String) async -> NetworkResult<BaseResponse<TokenResponse>> {
        await request(.refresh(refreshToken), res: BaseResponse<TokenResponse>.self)
    }
    
    public func sendEmailCode(req: EmailCodeRequest) async -> NetworkResult<BaseResponse<VoidResponse>> {
        await request(.sendEmailCode(req), res: BaseResponse<VoidResponse>.self)
    }
}
