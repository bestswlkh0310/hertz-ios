import XCTest
@testable import Hertz

class Test: XCTestCase {
    
    func testSignUp() async {
        let req = SignUpRequest(username: "test", password: "test", passwordCheck: "test", code: "")
        let response = await NetworkService.shared.userService.signUp(req: req)
        printResult(response: response)
        if case .success(_) = response {
            
        } else {
            print(response)
            XCTFail("sign up failure")
        }
    }
    
    func testSignIn() async {
        let req = SignInRequest(username: "test", password: "test")
        let response = await NetworkService.shared.userService.signIn(req: req)
        printResult(response: response)
    }
    
    func testRefresh() async {
        let refreshToken = ""
        let response = await NetworkService.shared.userService.refresh(refreshToken: refreshToken)
        printResult(response: response)
        
        if case .success(_) = response {
            
        } else {
            XCTFail("refresh failure")
        }
    }
    
    func testSendEmailCode() async {
        let req = EmailCodeRequest(to: "hhhello0507@gmail.com")
        let response = await NetworkService.shared.userService.sendEmailCode(req: req)
        printResult(response: response)
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
