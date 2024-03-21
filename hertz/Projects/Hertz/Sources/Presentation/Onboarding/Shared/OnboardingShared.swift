import Then
public class OnboardingShared {
    
    private init() {}
    public static let shared = OnboardingShared()
    
    public var username = ""
    public var password = ""
    public var passwordCheck = ""
    public var code = ""
    
    public func makeSignUpRequest() -> SignUpRequest {
        SignUpRequest(username: username,
                      password: password,
                      passwordCheck: passwordCheck,
                      code: code)
    }
}

extension OnboardingShared: Then {}
