import XCTest
@testable import Hertz

class MyAppTests: XCTestCase {
    
    func testSignUp() async {
        let req = SignUpRequest(username: "test", password: "test", passwordCheck: "test")
        let response = await UserService.shared.signUp(req: req)
        printResult(response: response)
        if case .success(let t) = response {
            
        } else {
            XCTFail("sign up failure")
        }
    }
    
    func testSignIn() async {
        let req = SignInRequest(username: "test", password: "test")
        let response = await UserService.shared.signIn(req: req)
        printResult(response: response)
    }
    
    func testRefresh() async {
        let refreshToken = ""
        let response = await UserService.shared.refresh(refreshToken: refreshToken)
        printResult(response: response)
        
        if case .success(let t) = response {
            
        } else {
            XCTFail("refresh failure")
        }
    }
    
    private func printResult<T>(response: NetworkResult<T>) {
        switch response {
        case .success(let r):
            print(r)
        case .requestErr(let e):
            print(e)
        default:
            print(response)
        }
    }
}
