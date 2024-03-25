import UIKit

class SignUpViewController: BaseViewController {
    
    let signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signUpView
        title = "회원가입"
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
        signUpView.signInButton.addTarget(self, action: #selector(navigateSignIn), for: .touchUpInside)
        signUpView.continueButton.addTarget(self, action: #selector(navigateCode), for: .touchUpInside)
    }
    
    @objc
    func navigateSignIn() {
        let signInViewController = SignInViewController()
        navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    @objc
    func navigateCode() {
        let email = signUpView.emailTextField.text ?? ""
        let password = signUpView.passwordTextField.text ?? ""
        let passwordCheck = signUpView.passwordCheckTextField.text ?? ""
        
        if email.isEmpty {
            showAlert(title: "이메일을 입력해 주세요")
        } else if password.isEmpty {
            showAlert(title: "비밀번호를 입력해 주세요")
        } else if passwordCheck.isEmpty {
            showAlert(title: "비밀번호를 재입력해 주세요")
        } else if password != passwordCheck {
            showAlert(title: "비밀번호가 일치하지 않습니다.")
        } else {
            OnboardingShared.shared.do {
                $0.username = email
                $0.password = password
                $0.passwordCheck = passwordCheck
            }
            let codeViewController = CodeViewController()
            navigationController?.pushViewController(codeViewController, animated: true)
        }
    }
}

extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
