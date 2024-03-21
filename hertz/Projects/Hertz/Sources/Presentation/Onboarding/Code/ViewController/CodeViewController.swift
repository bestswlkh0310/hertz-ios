import UIKit

class CodeViewController: BaseViewController {
    
    let codeView = CodeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = codeView
        title = "이메일 인증"
        hideKeyboardWhenTappedAround()
        
        // MARK: configure
        configureAddTarget()
        dismiss = {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureAddTarget() {
        codeView.requestButton.addTarget(self, action: #selector(requestEmailCode), for: .touchUpInside)
    }
    
    @objc
    func requestEmailCode() {
        Task {
            let req = EmailCodeRequest(to: OnboardingShared.shared.username)
            let result = await NetworkService.shared.userService.sendEmailCode(req: req)
            switch result {
            case .success(_):
                print("request email code success")
                DispatchQueue.main.async {
                    // TODO: change state
                }
                break
            default:
                print(result)
                codeView.showToast(message: "이메일 전송 실패")
                break
            }
        }
    }
    
    func saveCodeForShared() {
        OnboardingShared.shared.code = codeView.codeTextField.text ?? ""
    }
    
    @objc
    func signUp() {
        saveCodeForShared()
        Task {
            let req = OnboardingShared.shared.makeSignUpRequest()
            let result = await NetworkService.shared.userService.signUp(req: req)
            switch result {
            case .success(let response):
                
                UserCache.shared.saveToken(response.data.accessToken, for: .accessToken)
                UserCache.shared.saveToken(response.data.refreshToken, for: .refreshToken)
                DispatchQueue.main.async {
                    self.navigateHome()
                }
                    
            default:
                break
            }
        }
    }
    
    func navigateHome() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

extension CodeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
