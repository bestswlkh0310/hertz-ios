import UIKit

class CodeViewController: BaseViewController {
    
    let codeView = CodeView()
    var isEmailFetching = false {
        didSet {
            codeView.requestButton.isEnabled = !isEmailFetching
        }
    }
    
    var isSignUpFetching = false {
        didSet {
            codeView.continueButton.isEnabled = !isSignUpFetching
        }
    }
    
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
        codeView.continueButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc
    func requestEmailCode() {
        isEmailFetching = true
        Task {
            defer { isEmailFetching = false }
            let req = EmailCodeRequest(to: OnboardingShared.shared.username)
            let result = await NetworkService.shared.userService.sendEmailCode(req: req)
            switch result {
            case .success(_):
                print("request email code success")
                DispatchQueue.main.async {
                    // TODO: change state
                    self.codeView.requestButton.do {
                        $0.backgroundColor = .clear
                        $0.setTitle("전송 완료", for: .normal)
                        $0.setTitleColor(.gray500, for: .normal)
                    }
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
        if OnboardingShared.shared.code.count != 6 {
            showAlert(title: "코드를 6글자로 입력해 주세요")
        } else {
            isSignUpFetching = true
            Task {
                defer { isSignUpFetching = false }
                let req = OnboardingShared.shared.makeSignUpRequest()
                let result = await NetworkService.shared.userService.signUp(req: req)
                switch result {
                case .success(let response):
                    UserCache.shared.saveToken(response.data.accessToken, for: .accessToken)
                    UserCache.shared.saveToken(response.data.refreshToken, for: .refreshToken)
                    DispatchQueue.main.async {
                        self.navigateHome()
                    }
                case .error:
                    showAlert(title: "코드가 일치하지 않습니다.")
                    break
                case .networkError:
                    showAlert(title: "네트워크 에러가 발생했습니다.")
                default:
                    showAlert(title: "알 수 없는 에러가 발생했습니다.")
                    break
                }
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
