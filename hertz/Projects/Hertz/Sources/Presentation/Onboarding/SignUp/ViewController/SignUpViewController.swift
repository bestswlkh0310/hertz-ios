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
        OnboardingShared.shared.do {
            $0.username = signUpView.emailTextField.text ?? ""
            $0.password = signUpView.passwordTextField.text ?? ""
            $0.passwordCheck = signUpView.passwordCheckTextField.text ?? ""
        }
        let codeViewController = CodeViewController()
        navigationController?.pushViewController(codeViewController, animated: true)
    }
}

extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
