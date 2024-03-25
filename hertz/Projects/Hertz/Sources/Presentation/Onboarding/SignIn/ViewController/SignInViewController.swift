import UIKit

class SignInViewController: BaseViewController {
    
    let signInView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signInView
        title = "로그인"
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
        signInView.signUpButton.addTarget(self, action: #selector(navigateSignUp), for: .touchUpInside)
        signInView.continueButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    @objc
    func navigateSignUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc
    func signIn() {
        guard let email = signInView.emailTextField.text else { return }
        guard let password = signInView.passwordTextField.text else { return }
        
        if email.isEmpty {
            showAlert(title: "이메일을 입력해 주세요")
        } else if password.isEmpty {
            showAlert(title: "비밀번호를 입력해 주세요")
        } else {
            let request = SignInRequest(username: email, password: password)
            Task {
                let result = await NetworkService.shared.userService.signIn(req: request)
                switch result {
                case .success(let response):
                    // TODO: handle token
                    print(response)
                    
                    UserCache.shared.saveToken(response.data.accessToken, for: .accessToken)
                    UserCache.shared.saveToken(response.data.refreshToken, for: .refreshToken)
                    
                    let homeViewController = HomeViewController()
                    navigationController?.pushViewController(homeViewController, animated: true)
                case .requestErr(let res):
                    print(result)
                    break
                case .networkErr:
                    showAlert(title: "네트워크 에러가 발생했습니다.")
                default:
                    showAlert(title: "알 수 없는 에러가 발생했습니다.")
                    break
                }
            }
        }
    }
}

extension SignInViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
